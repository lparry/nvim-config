
vim.keymap.set('n', '<leader><space>', ':noh<cr>')
vim.keymap.set({'n', 'v'}, 'j', 'gj')
vim.keymap.set({'n', 'v'}, 'k', 'gk')

vim.keymap.set('n', '<Leader>u', ':MundoToggle<cr>')

-- " Arrow keys navigate split windows
vim.keymap.set('n', '<Up>', '<C-W><Up>')
vim.keymap.set('n', '<Down>', '<C-W><Down>')
vim.keymap.set('n', '<Left>', '<C-W><Left>')
vim.keymap.set('n', '<Right>', '<C-W><Right>')

-- cycle buffers
vim.keymap.set('n', '<C-n>', ':bn<cr>')
vim.keymap.set('n', '<C-p>', ':bp<cr>')

-- expand %% to the current file's directory
vim.cmd('cnoremap <expr> %% getcmdtype() == ":" ? expand("%:h")."/" : "%%"')
vim.cmd('cnoremap <expr> <C-T> getcmdtype() == ":" ?  : "<C-T>"')

--  spelling stuff
-- setlocal spell spelllang=en_au
vim.keymap.set('n', '<F5>', ':setlocal spell! spelllang=en_au<cr>')
vim.keymap.set('i', '<F5>', '<ESC>:setlocal spell! spelllang=en_au<cr>')

vim.keymap.set('i', 'jj', '<ESC>')

-- -- "ctrl + a/e to move to end/start of lines
-- trialing tpope/rsi
-- vim.keymap.set('n', '<C-a>', '^')
-- vim.keymap.set('n', '<C-e>', '$')
-- vim.keymap.set('c', '<C-a>', '<home>')
-- vim.keymap.set('c', '<C-e>', '<end>')
-- vim.keymap.set('i', '<C-e>', '<ESC>A')
-- vim.keymap.set('i', '<C-a>', '<ESC>I')

-- reselect selection after altering indent
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- maximize windows
vim.keymap.set('n', '_', '<c-w>_')
vim.keymap.set('n', '+', '<c-w>+')

-- colon commands (must start with capital letters sadly)
vim.cmd('command W write')
vim.cmd('command Q quit')  -- compensate for my sloppy typing
vim.cmd('command WQ write | quit')
vim.cmd('command Wq write | quit')
vim.cmd('command QW write | quit')

-- vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
-- map <Leader>w :call TidyWhiteSpace()<CR>
-- map <Leader>W :call TidyWhiteSpaceAggressive()<CR>

vim.keymap.set('n', '<Leader>j', ':silent vs <C-R>=rspec#SpecOrCodeToggle() <CR> <CR>')

-- buffer management
vim.keymap.set('n', '<leader>bd', ":bd<cr>")
--vim.keymap.set('n', '<Leader>bd', ':bd<cr>')
vim.keymap.set('n', '<Leader>bn', ':bnext<cr>')
vim.keymap.set('n', '<Leader>bp', ':bprevious<cr>')
vim.keymap.set('n', '<Leader>bD', ':bd!<cr>')

-- apparently these two lines make vim use normal regex, sadly i know a mangle
-- of vim and perl regex so it's gonna hurt for a bit
-- vim.keymap.set('n', '/', '/\v')
-- vim.keymap.set('v', '/', '/\v')

-- exiting insert mode should go back to the same cursor place
vim.keymap.set('i', '<ESC>', '<ESC>l')

-- Display errors on hover
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {scope = "line", border = "single", focus=false})]]

vim.keymap.set('n', '<Leader>r', ':Rufo<cr>')
