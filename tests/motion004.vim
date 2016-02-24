" Test replacing with single-char motion.

normal! 15G0)
normal "agrl
normal! 14G0)
normal grh

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
