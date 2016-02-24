" Test replacing with motion within the same line. 

normal! 15G0)
normal "agr$
normal! 14G0)
normal gr)

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
