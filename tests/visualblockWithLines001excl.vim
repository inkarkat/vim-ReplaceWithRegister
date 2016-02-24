" Test replacing a blockwise selection with lines. 
" Tests that the lines are pasted blockwise, even though the register is
" linewise. 

set selection=exclusive

execute "normal! 4G02w\<C-v>l2ej"
normal "mgr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
