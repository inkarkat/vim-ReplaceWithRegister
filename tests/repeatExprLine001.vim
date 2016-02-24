" Test repeat replacing a word with an expression line. 
" Tests that the same register is used on repetition. 
" Tests that the expression is re-evaluated on repetition. 

normal! 3G02W
execute "normal \"=Foo()\<CR>grr"

normal! jW0
normal .
normal! jW0
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
