" Test replacing a single-char characterwise selection.

set selection=exclusive

normal! 15G0)vl
normal "agr
normal! 14G0)vh
normal gr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
