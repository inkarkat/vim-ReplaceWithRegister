" Test replacing a single line with word. 

normal! 3G02W
normal "agrr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
