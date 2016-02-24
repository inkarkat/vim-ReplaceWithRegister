" Test replacing with text object. 

normal! 14G0)
normal grip
normal! 3G02W
normal "agrit

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
