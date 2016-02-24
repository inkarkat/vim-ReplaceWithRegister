" Test repeat replacing a single line with word. 
" Tests that the same register is used on repetition. 

normal! 3G02W
normal "agrr

normal! 2jW
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
