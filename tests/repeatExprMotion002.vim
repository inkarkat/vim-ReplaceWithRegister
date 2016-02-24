" Test count-repeat replacing a word with an expression motion. 
" Tests that the count is correctly repeated. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
execute "normal \"=Foo()\<CR>grE"

normal! j0
normal 2.
normal! j0
normal 4.
normal! 9j0
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
