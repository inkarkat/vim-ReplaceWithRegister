" Test count-repeat replacing a line with an expression visual selection. 
" Tests that the repeat count is applied. 
" Tests that the repeat count is kept for subsequent repeats without count. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')
runtime plugin/visualrepeat.vim

set selection=exclusive

normal! 6G0V
execute "normal \"=Foo()\<CR>gr"

normal! 4G0W
normal .

normal! 14G0
normal 3.

normal! 9G0
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
