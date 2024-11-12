" Test replacing with a text object that starts right at the end of the line.

0insert
<div>
    some_old_text
</div>
.

let @" = 'some_new_text'
1normal grit

call vimtest#SaveOut()
call vimtest#Quit()
