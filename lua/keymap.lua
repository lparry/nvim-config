local k = require('util.keymap')

k.nnoremap('<leader><space>', ':noh<cr>')
k.nnoremap('j', 'gj')
k.nnoremap('k', 'gk')
k.vnoremap('j', 'gj')
k.vnoremap('k', 'gk')

-- " Arrow keys navigate split windows
k.nmap('<Up>', '<C-W><Up>')
k.nmap('<Down>', '<C-W><Down>')
k.nmap('<Left>', '<C-W><Left>')
k.nmap('<Right>', '<C-W><Right>')

-- cycle buffers
k.nmap('<C-n>', ':bn<cr>')
k.nmap('<C-p>', ':bp<cr>')

-- expand %% to the current file's directory
vim.cmd('cnoremap <expr> %% getcmdtype() == ":" ? expand("%:h")."/" : "%%"')
vim.cmd('cnoremap <expr> <C-T> getcmdtype() == ":" ?  : "<C-T>"')
vim.cmd('nnoremap <silent> g? <cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')

--  spelling stuff
-- setlocal spell spelllang=en_au
k.nmap('<F5>', ':setlocal spell! spelllang=en_au<cr>')
k.imap('<F5>', '<ESC>:setlocal spell! spelllang=en_au<cr>')

k.imap('jj', '<ESC>')

-- -- "ctrl + a/e to move to end/start of lines
-- trialing tpope/rsi
-- k.nmap('<C-a>', '^')
-- k.nmap('<C-e>', '$')
-- k.cmap('<C-a>', '<home>')
-- k.cmap('<C-e>', '<end>')
-- k.imap('<C-e>', '<ESC>A')
-- k.imap('<C-a>', '<ESC>I')

-- reselect selection after altering indent
k.vmap('>', '>gv')
k.vmap('<', '<gv')

-- maximize windows
k.nmap('_', '<c-w>_')
k.nmap('+', '<c-w>+')

-- colon commands (must start with capital letters sadly)
vim.cmd('command W write')
vim.cmd('command Q quit')  -- compensate for my sloppy typing
vim.cmd('command WQ write | quit')
vim.cmd('command Wq write | quit')
vim.cmd('command QW write | quit')

-- vmap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
-- map <Leader>w :call TidyWhiteSpace()<CR>
-- map <Leader>W :call TidyWhiteSpaceAggressive()<CR>

k.nmap('<Leader>j', ':silent vs <C-R>=rspec#SpecOrCodeToggle() <CR> <CR>')

-- buffer management
k.nmap('<Leader>bd', ':bd<cr>')
k.nmap('<Leader>bn', ':bnext<cr>')
k.nmap('<Leader>bp', ':bprevious<cr>')
k.nmap('<Leader>bD', ':bd!<cr>')

-- apparently these two lines make vim use normal regex, sadly i know a mangle
-- of vim and perl regex so it's gonna hurt for a bit
-- k.nnoremap('/', '/\v')
-- k.vnoremap('/', '/\v')

-- exiting insert mode should go back to the same cursor place
k.imap('<ESC>', '<ESC>l')

-- Display errors on hover
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {scope = "line", border = "single", focus=false})]]

