" Test count-repeat replacing a word with an expression line.
" Tests that the count is correctly repeated.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
execute "normal \"=Foo()\<CR>grr"

normal! 2j0W
normal 3.
normal! 4j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
