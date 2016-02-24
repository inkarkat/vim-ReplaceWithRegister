" Test replacing a single line with multiple lines. 

normal! 3G02W
normal "mgrr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
