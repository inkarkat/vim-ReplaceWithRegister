" Test replacing multiple lines with word. 

call vimtest#SkipAndQuitIf(! vimtest#features#SupportsNormalWithCount(), 'Need support for :normal with count')

normal! 3G02W
normal "a3grr

call VerifyRegisters()
call vimtest#SaveOut()
call vimtest#Quit()
