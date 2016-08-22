" Test count-repeat replacing a line with word.
" Tests that the count is correctly repeated.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
normal grr

normal! 2jW
normal 3.
normal! 4j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
