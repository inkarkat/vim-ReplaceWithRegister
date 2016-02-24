" Test replacing a linewise selection. 

set selection=exclusive

normal! 14G0Vj
normal "lgr
normal! 5G0V2j
normal gr
normal! 3G0V
normal "agr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
