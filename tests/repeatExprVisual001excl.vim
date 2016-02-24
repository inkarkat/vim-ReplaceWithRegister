" Test repeat replacing chars with an expression visual selection. 
" Tests that the same register is used on repetition. 
" Tests that the expression is re-evaluated on repetition. 
" Tests that the visual mode mapping repeats in normal mode. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

runtime plugin/visualrepeat.vim

set selection=exclusive

normal! 15G0)v$
execute "normal \"=Foo()\<CR>gr"

normal! 14G0)v)
normal .

normal! W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
