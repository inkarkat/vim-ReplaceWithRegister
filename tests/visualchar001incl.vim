" Test replacing a characterwise selection. 

set selection=inclusive

normal! 15G0)v$
normal "agr
normal! 14G0)v)
normal gr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
