" ReplaceWithRegister.vim: Replace text with the contents of a register.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"
" Copyright: (C) 2008-2019 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_ReplaceWithRegister') || (v:version < 700)
    finish
endif
let g:loaded_ReplaceWithRegister = 1

let s:save_cpo = &cpo
set cpo&vim

" This mapping repeats naturally, because it just sets global things, and Vim is
" able to repeat the g@ on its own.
nnoremap <expr> <Plug>ReplaceWithRegisterOperator ReplaceWithRegister#OperatorExpression()
" But we need repeat.vim to get the expression register re-evaluated: When Vim's
" . command re-invokes 'opfunc', the expression isn't re-evaluated, an
" inconsistency with the other mappings. We creatively use repeat.vim to sneak
" in the expression evaluation then.
nnoremap <silent> <Plug>ReplaceWithRegisterExpressionSpecial :<C-u>let g:ReplaceWithRegister#expr = getreg('=')<Bar>execute 'normal!' v:count1 . '.'<CR>

" This mapping needs repeat.vim to be repeatable, because it consists of
" multiple steps (visual selection + 'c' command inside
" ReplaceWithRegister#Operator).
nnoremap <silent> <Plug>ReplaceWithRegisterLine
\ :<C-u>call setline('.', getline('.'))<Bar>
\execute 'silent! call repeat#setreg("\<lt>Plug>ReplaceWithRegisterLine", v:register)'<Bar>
\call ReplaceWithRegister#SetRegister()<Bar>
\if ReplaceWithRegister#IsExprReg()<Bar>
\    let g:ReplaceWithRegister#expr = getreg('=')<Bar>
\endif<Bar>
\call ReplaceWithRegister#SetCount()<Bar>
\execute 'normal! V' . v:count1 . "_\<lt>Esc>"<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterLine", 1)<CR>

" Repeat not defined in visual mode, but enabled through visualrepeat.vim.
vnoremap <silent> <Plug>ReplaceWithRegisterVisual
\ :<C-u>call setline('.', getline('.'))<Bar>
\execute 'silent! call repeat#setreg("\<lt>Plug>ReplaceWithRegisterVisual", v:register)'<Bar>
\call ReplaceWithRegister#SetRegister()<Bar>
\if ReplaceWithRegister#IsExprReg()<Bar>
\    let g:ReplaceWithRegister#expr = getreg('=')<Bar>
\endif<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterVisual")<CR>

" A normal-mode repeat of the visual mapping is triggered by repeat.vim. It
" establishes a new selection at the cursor position, of the same mode and size
" as the last selection.
" If [count] is given, that number of lines is used / the original size is
" multiplied accordingly. This has the side effect that a repeat with [count]
" will persist the expanded size, just as it should.
" First of all, the register must be handled, though.
nnoremap <silent> <Plug>ReplaceWithRegisterVisual
\ :<C-u>call setline('.', getline('.'))<Bar>
\execute 'silent! call repeat#setreg("\<lt>Plug>ReplaceWithRegisterVisual", v:register)'<Bar>
\call ReplaceWithRegister#SetRegister()<Bar>
\if ReplaceWithRegister#IsExprReg()<Bar>
\    let g:ReplaceWithRegister#expr = getreg('=')<Bar>
\endif<Bar>
\execute 'normal!' ReplaceWithRegister#VisualMode()<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterVisual")<CR>


if ! hasmapto('<Plug>ReplaceWithRegisterOperator', 'n')
    nmap gr <Plug>ReplaceWithRegisterOperator
endif
if ! hasmapto('<Plug>ReplaceWithRegisterLine', 'n')
    nmap grr <Plug>ReplaceWithRegisterLine
endif
if ! hasmapto('<Plug>ReplaceWithRegisterVisual', 'x')
    xmap gr <Plug>ReplaceWithRegisterVisual
endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
