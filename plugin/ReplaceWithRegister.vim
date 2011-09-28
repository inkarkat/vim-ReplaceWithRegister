" ReplaceWithRegister.vim: Replace text with the contents of a register. 
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher. 
"   - ReplaceWithRegister.vim autoload script. 
"
" Copyright: (C) 2008-2011 by Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'. 
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS 
"   1.30.015	24-Sep-2011	ENH: Handling use of expression register "=. 
"				BUG: v:register is not replaced during command
"				repetition, so repeat always used the unnamed
"				register. Added parallel
"				<Plug>ReplaceWithRegisterRepeat... mappings that
"				omit the <SID>SetRegister() and <SID>IsExprReg()
"				stuff and are registered for repetition instead
"				of the original mappings. 
"				Moved functions from plugin to separate autoload
"				script. No need to pass <SID>-opfunc to
"				ReplaceWithRegister#OperatorExpression(). 
"   1.20.014	26-Apr-2011	BUG: ReplaceWithRegisterOperator didn't work
"				correctly with linewise motions (like "+"); need
"				to use a linewise visual selection in this case. 
"   1.20.013	23-Apr-2011	BUG: Text duplicated from yanked previous lines
"				is inserted on a replacement of a visual
"				blockwise selection. Need a special case, which
"				actually is tricky because of the detection of
"				the end-of-the-line in combination with having
"				two cursor positions (via v_o) in a blockwise
"				selection. Instead of following down that road,
"				switch to a put in visual mode in combination
"				with a save and restore of the unnamed register.
"				This should handle all cases and doesn't require
"				the autoindent workaround, neither. 
"   1.10.012	18-Mar-2011	The operator-pending mapping now also handles
"				'nomodifiable' and 'readonly' buffers without
"				function errors. Add checking and probing inside
"				s:ReplaceWithRegisterOperatorExpression(). 
"   1.10.011	17-Mar-2011	Add experimental support for repeating the
"				replacement also in visual mode through
"				visualrepeat.vim. Renamed vmap
"				<Plug>ReplaceWithRegisterOperator to
"				<Plug>ReplaceWithRegisterVisual for that. 
"				A repeat in visual mode will now apply the
"				previous line and operator replacement to the
"				selection text. A repeat in normal mode will
"				apply the previous visual mode replacement at
"				the current cursor position, using the size of
"				the last visual selection. 
"   1.03.010	07-Jan-2011	ENH: Better handling when buffer is
"				'nomodifiable' or 'readonly'. Using the trick of
"				prepending a no-op buffer modification before
"				invoking the functions. Using try...catch inside
"				s:ReplaceWithRegister() would break the needed
"				abort inside the :normal sequence of replacing
"				the selection, then inserting the register. The
"				disastrous result would be erroneous
"				interpretation of <C-O> as a normal mode
"				command! 
"   1.02.009	25-Nov-2009	Replaced the <SID>Count workaround with
"				:map-expr and an intermediate
"				s:ReplaceWithRegisterOperatorExpression. 
"   1.01.008	06-Oct-2009	Do not define "gr" mapping for select mode;
"				printable characters should start insert mode. 
"   1.00.007	05-Jul-2009	Renamed from ingooperators.vim. 
"				Replaced g:register with call to
"				s:SetRegister(). 
"	006	05-Mar-2009	BF: Besides 'autoindent', 'indentexpr' also
"				causes additional indent. Now completely turning
"				off all these things via the 'paste' option. 
"	005	23-Feb-2009	BF: When replacing a complete line over an
"				indented line (with 'Vgr' or 'grr'), the old
"				indent was kept. Now temporarily turning off
"				'autoindent' to avoid that. 
"	004	20-Feb-2009	BF: ReplaceWithRegisterOperator mapping didn't
"				work for "last line" G motion, because v:count1
"				defaulted to line 1. Now checking v:count and
"				mapping to <Nop> if no count was given. 
"	003	01-Feb-2009	Allowing repeating via '.' by avoiding the
"				script error about undefined variable
"				g:register. 
"				Put try...finally around temporary 'selection'
"				setting. 
"				ENH: Now allowing [count] in front of
"				gr{motion} (see :help ingo-opfunc for details)
"				and grr (via repeat.vim). 
"				Now correcting mismatch when replacement is
"				linewise by temporarily removing the trailing
"				newline. 
"	002	15-Aug-2008	Added {Visual}gr and grr mappings. 
"	001	11-Aug-2008	file creation

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

" Because v:register is not replayed during command repetition, the
" ReplaceWithRegister#SetRegister() part must not be part of the repetition, so
" that the saved value of s:register persists. 

" This mapping needs repeat.vim to be repeatable, because it contains of
" multiple steps (visual selection + 'c' command inside
" ReplaceWithRegister#Operator). 
nnoremap <silent> <Plug>ReplaceWithRegisterRepeatLine
\ :<C-u>call setline(1, getline(1))<Bar>
\execute 'normal! V' . v:count1 . "_\<lt>Esc>"<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterRepeatLine")<CR>

nnoremap <silent> <Plug>ReplaceWithRegisterLine
\ :<C-u>call setline(1, getline(1))<Bar>
\call ReplaceWithRegister#SetRegister()<Bar>
\if ReplaceWithRegister#IsExprReg()<Bar>
\    let g:ReplaceWithRegister_expr = getreg('=')<Bar>
\endif<Bar>
\execute 'normal! V' . v:count1 . "_\<lt>Esc>"<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterRepeatLine")<CR>

" Repeat not defined in visual mode. 
vnoremap <silent> <SID>ReplaceWithRegisterRepeatVisual
\ :<C-u>call setline(1, getline(1))<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterRepeatVisual")<CR>

vnoremap <silent> <SID>ReplaceWithRegisterVisual
\ :<C-u>call setline(1, getline(1))<Bar>
\call ReplaceWithRegister#SetRegister()<Bar>
\if ReplaceWithRegister#IsExprReg()<Bar>
\    let g:ReplaceWithRegister_expr = getreg('=')<Bar>
\endif<Bar>
\call ReplaceWithRegister#Operator('visual', "\<lt>Plug>ReplaceWithRegisterRepeatVisual")<CR>

vnoremap <silent> <script> <Plug>ReplaceWithRegisterVisual <SID>ReplaceWithRegisterVisual
nnoremap <expr> <SID>Reselect '1v' . (visualmode() !=# 'V' && &selection ==# 'exclusive' ? ' ' : '')
nnoremap <silent> <script> <Plug>ReplaceWithRegisterRepeatVisual <SID>Reselect<SID>ReplaceWithRegisterRepeatVisual


if ! hasmapto('<Plug>ReplaceWithRegisterOperator', 'n')
    nmap <silent> gr <Plug>ReplaceWithRegisterOperator
endif
if ! hasmapto('<Plug>ReplaceWithRegisterLine', 'n')
    nmap <silent> grr <Plug>ReplaceWithRegisterLine
endif
if ! hasmapto('<Plug>ReplaceWithRegisterVisual', 'x')
    xmap <silent> gr <Plug>ReplaceWithRegisterVisual
endif

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
