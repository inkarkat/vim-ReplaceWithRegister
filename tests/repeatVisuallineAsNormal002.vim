" Test repeat replacing a multi-line selection in normal mode. 
" Tests that the same register is used on repetition. 
" Tests that the same number of lines is used on normal mode repetition. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

set selection=inclusive

normal! 5G0V2j
normal "agr

normal! 3j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
