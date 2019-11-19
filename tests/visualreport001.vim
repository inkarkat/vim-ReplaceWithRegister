" Test reporting the changes.

" Load the optional dependencies to avoid the invocation errors about them.
call vimtest#AddDependency('vim-repeat')
call vimtest#AddDependency('vim-visualrepeat')

set report=3
call setreg('t', "two\nlines\n", 'l')

" Do one dummy replacement to flush out the "Warning: terminal cannot highlight"
" message that appears once.
1normal "lgrr

echomsg '1 with 1'
3normal V"lgr
echomsg 'nothing for 1 with 1'

echomsg '2 with 2'
3normal Vj"tgr
echomsg 'nothing for 2 with 2'

echomsg '3 with 2'
3normal V2j"tgr

echomsg '2 with 3'
3normal Vj"mgr

echomsg '3 with 3'
3normal V2j"mgr

call vimtest#Quit()
