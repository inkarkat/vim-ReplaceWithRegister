" Test repeat replacing a word with an expression motion. 
" Tests that the same register is used on repetition. 
" Tests that the expression is re-evaluated on repetition. 

normal! 3G02W
execute "normal \"=Foo()\<CR>gre"

normal! j0
normal .
normal! j0
normal .

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
