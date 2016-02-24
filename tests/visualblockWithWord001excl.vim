" Test replacing a blockwise selection with a word. 
" Tests that the word is duplicated to match the height of the blockwise
" selection. 

set selection=exclusive

execute "normal! 4G02w\<C-v>l2ej"
normal "agr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
