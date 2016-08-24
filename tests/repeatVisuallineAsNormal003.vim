" Test repeat replacing a multi-line selection in normal mode.

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

set selection=inclusive

normal! 3G0Vj
normal "igr

normal! 6j
normal 3.

normal! 2j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
