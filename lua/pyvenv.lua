local M = {}

-- Configuration
local config = {
  log_level = "ERROR", -- DEBUG, INFO, WARN, ERROR
}

-- Log levels
local LOG_LEVELS = {
  DEBUG = 0,
  INFO = 1,
  WARN = 2,
  ERROR = 3,
}

-- Logging function
local function log(level, message)
  local current_level = LOG_LEVELS[config.log_level] or LOG_LEVELS.INFO
  local msg_level = LOG_LEVELS[level] or LOG_LEVELS.INFO
  
  if msg_level >= current_level then
    local timestamp = os.date("%H:%M:%S")
    local prefix = string.format("[%s] [%s]", timestamp, level)
    local full_message = prefix .. " " .. message
    
    -- Map log levels to vim.notify levels
    local notify_level = vim.log.levels.INFO
    if level == "DEBUG" then
      notify_level = vim.log.levels.DEBUG
    elseif level == "INFO" then
      notify_level = vim.log.levels.INFO
    elseif level == "WARN" then
      notify_level = vim.log.levels.WARN
    elseif level == "ERROR" then
      notify_level = vim.log.levels.ERROR
    end
    
    vim.notify(full_message, notify_level, { title = "Python Environment" })
  end
end

-- Path to the Python virtual environment for Neovim
local venv_path = vim.fn.stdpath("data") .. "/py-venv"
local python_path = venv_path .. "/bin/python"

-- Check if a command exists
local function binary_exists(cmd)
  return vim.fn.executable(cmd) == 1
end

-- Execute a command and return success status
local function execute_command(cmd)
  local result = vim.fn.system(cmd)
  return vim.v.shell_error == 0, result
end

-- Find uv installation path
local function find_uv_path()
  local success, uv_full_path = execute_command("which uv")
  if success and uv_full_path then
    -- Remove any trailing whitespace/newlines
    uv_full_path = uv_full_path:gsub("%s+$", "")
    -- Return the directory path
    return vim.fn.fnamemodify(uv_full_path, ":h")
  end
  
  return nil
end

-- Install uv if not present
local function install_uv()
  if binary_exists("uv") then
    log("DEBUG", "uv is already installed")
    return true
  end
  
  log("INFO", "Installing uv...")
  local install_cmd = "curl -LsSf https://astral.sh/uv/install.sh | sh"
  log("DEBUG", "Running command: " .. install_cmd)
  local success, output = execute_command(install_cmd)
  
  if success then
    log("INFO", "uv installed successfully")
    -- Find and add uv to PATH for current session
    local uv_path = find_uv_path()
    if uv_path then
      vim.env.PATH = uv_path .. ":" .. vim.env.PATH
      log("DEBUG", "Added uv path to PATH: " .. uv_path)
    else
      log("WARN", "Could not find uv installation path")
    end
    return true
  else
    log("ERROR", "Failed to install uv: " .. output)
    return false
  end
end

-- Create virtual environment using uv
local function create_venv()
  if vim.fn.isdirectory(venv_path) == 1 then
    log("DEBUG", "Python virtual environment already exists at " .. venv_path)
    return true
  end
  
  log("INFO", "Creating Python virtual environment...")
  local cmd = "uv venv -p 3.12 " .. venv_path
  log("DEBUG", "Running command: " .. cmd)
  local success, output = execute_command(cmd)
  
  if success then
    log("INFO", "Virtual environment created successfully at " .. venv_path)
    return true
  else
    log("ERROR", "Failed to create virtual environment: " .. output)
    return false
  end
end

-- Check if a package is installed
local function is_package_installed(package_name)
  -- Remove extras specification (e.g., "python-lsp-server[all]" -> "python-lsp-server")
  local base_package = package_name:gsub("%[.*%]", "")
  local cmd = "uv pip show --python " .. python_path .. " " .. base_package
  local success, _ = execute_command(cmd)
  return success
end

-- Install required Python packages
local function install_packages()
  local packages = {
    "pynvim",           -- Neovim Python client
    "debugpy",          -- Python debugger
    "black",            -- Python formatter
    "isort",            -- Import sorter
    "flake8",           -- Linter
    "mypy",             -- Type checker
    "pylsp-mypy",       -- MyPy plugin for Python LSP
    "python-lsp-server[all]", -- Python Language Server
  }
  
  log("INFO", "Checking and installing Python packages...")
  for _, package in ipairs(packages) do
    if is_package_installed(package) then
      log("DEBUG", "Package " .. package .. " is already installed, skipping...")
    else
      log("INFO", "Installing " .. package .. "...")
      local cmd = "uv pip install --python " .. python_path .. " " .. package
      log("DEBUG", "Running command: " .. cmd)
      local success, output = execute_command(cmd)
      
      if success then
        log("INFO", "Successfully installed " .. package)
      else
        log("ERROR", "Failed to install " .. package .. ": " .. output)
      end
    end
  end
  
  log("INFO", "Python packages installation completed")
end

-- Setup function to be called
function M.setup(user_config)
  -- Merge user config with default config
  if user_config then
    config = vim.tbl_deep_extend("force", config, user_config)
  end
  
  log("INFO", "Starting Python environment setup...")
  log("DEBUG", "Log level set to: " .. config.log_level)
  log("DEBUG", "Virtual environment path: " .. venv_path)
  log("DEBUG", "Python executable path: " .. python_path)
  
  -- Check and install uv
  if not install_uv() then
    log("ERROR", "Failed to install uv, aborting setup")
    return false
  end
  
  -- Create virtual environment
  if not create_venv() then
    log("ERROR", "Failed to create virtual environment, aborting setup")
    return false
  end
  
  -- Install required packages
  install_packages()
  
  -- Set Python provider for Neovim
  if vim.fn.filereadable(python_path) == 1 then
    vim.g.python3_host_prog = python_path
    log("INFO", "Python environment setup completed. Python path: " .. python_path)
  else
    log("WARN", "Python executable not found at " .. python_path)
  end
  
  return true
end

-- Function to set log level
function M.set_log_level(level)
  if LOG_LEVELS[level] then
    config.log_level = level
    log("INFO", "Log level changed to: " .. level)
  else
    log("WARN", "Invalid log level: " .. level .. ". Valid levels: DEBUG, INFO, WARN, ERROR")
  end
end

-- Auto-setup on require
M.setup()

return M
