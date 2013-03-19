runtime plugin/ReplaceWithRegister.vim

read input.txt
1delete _

call setreg('a', 'abyss', 'c')
call setreg('b', "block\ntext!", 'b')
call setreg('i', "\t    indented text\n", 'l')
call setreg('l', "one line of text\n", 'l')
call setreg('m', "multiple\nlines of\ntext\n", 'l')

normal! gg0yy

let s:foo = 0
function! Foo()
    let s:foo += 1
    return s:foo
endfunction

function! VerifyRegisters()
    call vimtest#StartTap()
    call vimtap#Plan(2)
    call vimtap#Is(getreg('"'), "[default text]\n", 'unnamed register contains original text')
    call vimtap#Is(getregtype('"'), 'V', 'unnamed register contains original yank type')
endfunction
