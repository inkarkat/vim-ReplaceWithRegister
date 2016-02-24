" Test replacing a blockwise selection with a line. 
" Tests that the line is duplicated to match the height of the blockwise
" selection. 

set selection=inclusive

execute "normal! 4G02w\<C-v>l2ej"
normal "lgr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
