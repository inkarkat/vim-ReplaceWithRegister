" Test that the replacement does not affect the jump list.

normal! ggG3G02W
normal gr$
execute "normal! jjj\<C-o>r1\<C-o>r2"

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
