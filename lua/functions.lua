-- " helpful tab completion
-- function! InsertTabWrapper(direction)
--     let col = col('.') - 1
--     if !col || getline('.')[col - 1] !~ '\k'
--         return "\<tab>"
--     elseif "backward" == a:direction
--         return "\<c-p>"
--     else
--         return "\<c-n>"
--     endif
-- endfunction

-- inoremap <tab> <c-r>=InsertTabWrapper("forward")<cr>
-- inoremap <s-tab> <c-r>=InsertTabWrapper("backward")<cr>

-- function! ReplaceTabsWithSpaces()
--   if search('\t')
--     :%s/\t/  /g
--   endif
-- endfunction

-- function! RemoveDoubleBlankLines()
--   if search('\n\s*\n\s*\n')
--     :%s/\n\s*\n\s*\n/\r\r/g
--   endif
-- endfunction
-- function! RemoveDoubleBlankLines()
--   if search('\n\s*\n\s*\n')
--     :%s/\n\s*\n\s*\n/\r\r/g
--   endif
-- endfunction

-- function! TidyWhiteSpace()
--   if search('\S\s\+$')
--     :%s/\(\S\)\s\+$/\1/
--   endif
--   call ReplaceTabsWithSpaces()
--   call RemoveDoubleBlankLines()
-- endfunction

-- function! TidyWhiteSpaceAggressive()
--   if search('\s\+$')
--     :%s/\s\+$//
--   endif
--   call ReplaceTabsWithSpaces()
--   call RemoveDoubleBlankLines()
-- endfunction
