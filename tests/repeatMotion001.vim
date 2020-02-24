" Test repeat replacing a word with a motion.
" Tests that the same register is used on repetition.

normal! 3G02W
normal "agre

normal! j0
normal .
normal! j0
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
