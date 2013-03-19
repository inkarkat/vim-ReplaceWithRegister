" Test replacing a single line with a single line. 

normal! 3G02W
normal grr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
