" Test repeat replacing a single line with word in visual modes. 
" Tests that the same register is used on repetition. 

runtime plugin/visualrepeat.vim

normal! 3G02W
normal "agrr

normal! 2jV2j
normal .

" The behavior when pasting over a visual selection to the EOL is different,
" depending on the 'selection' value. 
set selection=exclusive	" This will replace over the line. 
normal! 3j0W
normal v$.
set selection=inclusive " This will replace and join the next line. 
normal! j0W
normal v$.

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
