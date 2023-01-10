vim.g.gutentags_project_root = { ".root", ".svn", ".git", ".hg", ".project", "package.json" }

vim.g.gutentags_cache_dir = vim.fn.expand("~/.cache/tags")
vim.g.gutentags_ctags_extra_args = { "-R", "--fields=+niazS", "--extras=+q", "--c++-kinds=+px", "--c-kinds=+px" }

if not vim.fn.isdirectory(vim.g.gutentags_cache_dir) then
	vim.fn.mkdir(vim.g.gutentags_cache_dir)
end

vim.g.gutentags_ctags_exclude = {
	"*.git",
	"*.svn",
	"*.hg",
	"cache",
	"dist",
	"bin",
	"node_modules",
	"bower_components",
	"*-lock.json",
	"*.lock",
	"*.min.*",
	"CMakeLists.txt",
	"*.bak",
	"*.zip",
	"*.pyc",
	"*.class",
	"*.sln",
	"*.csproj",
	"*.csproj.user",
	"*.tmp",
	"*.cache",
	"*.vscode",
	"*.pdb",
	"*.pb",
	"*.exe",
	"*.dll",
	"*.bin",
	"*.mp3",
	"*.ogg",
	"*.flac",
	"*.swp",
	"*.swo",
	".DS_Store",
	"*.plist",
	"*.bmp",
	"*.gif",
	"*.ico",
	"*.jpg",
	"*.png",
	"*.svg",
	"*.rar",
	"*.zip",
	"*.tar",
	"*.tar.gz",
	"*.tar.xz",
	"*.tar.bz2",
	"*.pdf",
	"*.doc",
	"*.docx",
	"*.ppt",
	"*.pptx",
	"*.xls",
}

vim.g.gutentags_trace = 0