" Test replacing an empty selection.

set selection=inclusive

normal! 4G02wv
normal "agr
normal! 9GV
normal gr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
