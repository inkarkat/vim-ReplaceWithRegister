" Test replacing a blockwise selection. 

set selection=inclusive

execute "normal! 4G02w\<C-v>l2ej"
normal "bgr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
