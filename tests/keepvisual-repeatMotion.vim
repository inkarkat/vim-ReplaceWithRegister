" Test replacing with motion keeps a previous visual selection on repetition.

call vimtest#AddDependency('vim-ingo-library')
call vimtest#StartTap()
call vimtap#Plan(2)

execute "1normal! vee\<Esc>"
normal! 3G02W
normal "agre

call SetSelection()

normal! j0
normal .
call VerifySelection()

normal! j0
normal .
call VerifySelection()

call vimtest#Quit()
