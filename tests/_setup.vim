if g:runVimTest =~# 'repeat'
    call vimtest#AddDependency('vim-repeat')
endif
if g:runVimTest =~# 'repeat\w*Visual'
    call vimtest#AddDependency('vim-visualrepeat')
endif

runtime plugin/ReplaceWithRegister.vim

read input.txt
1delete _

call setreg('a', 'abyss', 'c')
call setreg('b', "block\ntext!", 'b')
call setreg('i', "\t    indented text\n", 'l')
call setreg('l', "one line of text\n", 'l')
call setreg('m', "multiple\nlines of\ntext\n", 'l')
call setreg('n', "  multiple\n\tlines of\n    text\n", 'l')

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

function! SetSelection()
    execute "2normal! 3W\<C-v>ej\<Esc>"
    let [s:startPos, s:endPos] = [getpos("'<"), getpos("'>")]
endfunction
function! VerifySelection( ... )
    call call((a:0 && ! a:1 ? 'vimtap#Isnt' : 'vimtap#Is'), [[getpos("'<"), getpos("'>")], [s:startPos, s:endPos], 'selection is unchanged'])
endfunction
