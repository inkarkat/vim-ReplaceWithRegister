" Test replacing with empty text object.

normal! 4G02w"_di'
normal "agri'
normal! 5G02w"_di'0
normal gri'

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
