" Test replacing an empty selection.

set selection=exclusive

normal! 4G02wv
normal "agr
normal! 9GV
normal gr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
