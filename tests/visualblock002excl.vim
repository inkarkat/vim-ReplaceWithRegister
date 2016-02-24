" Test replacing a blockwise selection at jagged edges. 

set selection=exclusive

execute "normal! 6G02l\<C-v>j$"
normal "bgr
execute "normal! 2G$B\<C-v>$j"
normal "bgr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
