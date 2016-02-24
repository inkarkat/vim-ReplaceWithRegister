" Test repeat replacing a linewise selection in normal mode. 
" Tests that the same register is used on repetition. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

set selection=inclusive

normal! 3G0V
normal "agr

normal! 2j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
