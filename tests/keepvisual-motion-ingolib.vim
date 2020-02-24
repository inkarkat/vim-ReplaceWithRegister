" Test keeping the previous visual selection depends on ingo-library.

" Do not call vimtest#AddDependency('vim-ingo-library')
call vimtest#StartTap()
call vimtap#Plan(3)
call SetSelection()

normal! 15G0)
normal "agr$
call VerifySelection(0)

normal! 14G0
normal "mgr+
call VerifySelection(0)

normal! 5G0f"
normal gr}
call VerifySelection(0)

call vimtest#Quit()
