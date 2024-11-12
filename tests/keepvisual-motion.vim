" Test replacing with motion keeps a previous visual selection.

call vimtest#AddDependency('vim-ingo-library')
call vimtest#StartTap()
call vimtap#Plan(3)
call SetSelection()

normal! 15G0)
normal "agr$
call VerifySelection()

normal! 14G0
normal "mgr+
call VerifySelection()

normal! 5G0f"
normal gr}
call VerifySelection()

call vimtest#Quit()
