" Test count-repeat replacing chars with an expression visual selection. 
" Tests that the repeat count is applied. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')
runtime plugin/visualrepeat.vim

set selection=exclusive

normal! 15G0)v3l
execute "normal \"=Foo()\<CR>gr"

normal! 14G0)
normal 3.

normal! 10G0
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
