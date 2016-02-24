" Test replacing with motion across lines. 

normal! 14G0
normal "mgr+
normal! 5G0f"
normal gr}

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
