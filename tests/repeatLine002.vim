" Test repeat replacing three lines with word.
" Tests that the count is correctly repeated.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
normal 3grr

normal! 4jW
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
