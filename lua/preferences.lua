-- follow the leader
vim.g.mapleader = " "

-- allow pretty colors in the terminal
vim.o.termguicolors = true

-- allow buffers to be hidden without writing to disk
vim.o.hidden = true

-- a tab looks like 2 spaces
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- we move forward + backward by 2 spaces at a time
vim.o.shiftwidth = 2

-- convert the <Tab> to spaces
vim.o.expandtab = true

-- show numbers relatively
vim.o.relativenumber = true

-- show the current line absolutely
vim.o.number = true

-- set sensible split defaults
vim.o.splitbelow = true
vim.o.splitright = true

-- set code columns
vim.o.cc = "100"

-- fold based on syntax
vim.o.foldmethod = "syntax"

-- turn off undofile so undo doesn't go back past when you opened the file
vim.o.undofile = false

-- start with folds disabled (enabled with zc)
vim.o.foldenable = false

-- show preview of replacements
vim.o.inccommand = "nosplit"

vim.o.completeopt = "menuone,noselect"

-- less shitty matching
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.infercase = true -- adjust case of match for keyword completion

-- sync with macos system clipboard
vim.o.clipboard = "unnamedplus"

vim.o.background = "dark"
vim.o.showmatch = true
vim.o.matchtime = 10
vim.o.scrolloff = 5
vim.o.listchars = "tab:>-,trail:·"
--vim.o.laststatus = 2

-- dont wrap
vim.o.wrap = false

---- backup files
---- set nobackup
---- set backupskip=/tmp/*,/private/tmp/*"
---- set noswapfile
--set undodir=~/tmp/vim/undo//
--set backupdir=~/tmp/vim/backup//
--set directory=~/tmp/vim/swp//

-- better filename completion
vim.o.wildmenu = true
vim.o.wildmode = "list:longest,full"
vim.o.wildignorecase = true

---- mouse works in insert mode
vim.o.mouse = "a"

-- something to do with showing regex replace results before commiting
vim.o.inccommand = "split"

-- Replace selected text with text in paste register, without overwriting the
-- text in the yank register with the text replaced.
vim.cmd [[
  colorscheme jellybeans-nvim

  " corrections and abbreviations
  iabbrev didnt didn't
  iabbrev dont don't
  iabbrev wasnt wasn't
  iabbrev im I'm
  iabbrev recieve receive
  iabbrev have_recieved have_received
  iabbrev teh the

  " save on focus lost
  autocmd FocusLost * silent! wa

  " Make .md files highlight as markdown
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.md set textwidth=100
  autocmd BufRead,BufNewFile *.markdown set textwidth=100
  autocmd BufNewFile,BufRead Podfile set filetype=ruby
]]

-- Strip trailing whitespaces on save
vim.api.nvim_create_autocmd(
    "BufWritePre",
    { pattern = "*", command = "%s/\\s\\+$//e" }
)
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
  { "BufRead", "BufNewFile" },
  {
      pattern = {
        "*.txt",
        "*.md",
        "*.markdown",
        "COMMIT_EDITMSG",
      },
      command = "setlocal spell spelllang=en_au",
  }
)
