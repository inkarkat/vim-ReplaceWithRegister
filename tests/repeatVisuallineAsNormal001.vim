" Test repeat replacing a linewise selection in normal mode. 
" Tests that the same register is used on repetition. 

set selection=inclusive

normal! 3G0V
normal "agr

normal! 2j0W
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
