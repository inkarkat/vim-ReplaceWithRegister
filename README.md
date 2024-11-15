REPLACE WITH REGISTER
===============================================================================
_by Ingo Karkat_

DESCRIPTION
------------------------------------------------------------------------------

Replacing an existing text with the contents of a register is a very common
task during editing. One typically first deletes the existing text via the
d, D or dd commands, then pastes the register with p or P. Most of
the time, the unnamed register is involved, with the following pitfall: If you
forget to delete into the black-hole register ("\_), the replacement text is
overwritten!

This plugin offers a two-in-one command that replaces text covered by a
{motion}, entire line(s) or the current selection with the contents of a
register; the old text is deleted into the black-hole register, i.e. it's
gone. (But of course, the command can be easily undone.)

The replacement mode (characters or entire lines) is determined by the
replacement command / selection, not by the register contents. This avoids
surprises like when the replacement text was a linewise yank, but the
replacement is characterwise: In this case, no additional newline is inserted.

### SEE ALSO

- ReplaceWithSameIndentRegister.vim ([vimscript #5046](http://www.vim.org/scripts/script.php?script_id=5046)) is a companion plugin
  for the special (but frequent) case of replacing lines while keeping the
  original indent.
- LineJugglerCommands.vim ([vimscript #4465](http://www.vim.org/scripts/script.php?script_id=4465)) provides a similar :Replace [["]x]
  Ex command.

### RELATED WORKS

- regreplop.vim ([vimscript #2702](http://www.vim.org/scripts/script.php?script_id=2702)) provides an alternative implementation of
  the same idea.
- operator-replace ([vimscript #2782](http://www.vim.org/scripts/script.php?script_id=2782)) provides replacement of {motion} only,
  depends on another library of the author, and does not have a default
  mapping.
- Luc Hermitte has an elegant minimalistic visual-mode mapping in
  https://github.com/LucHermitte/lh-misc/blob/master/plugin/repl-visual-no-reg-overwrite.vim
- EasyClip (https://github.com/svermeulen/vim-easyclip) changes the delete
  commands to stop yanking, introduces a new "m" command for cutting, and also
  provides an "s" substitution operator that pastes register contents over the
  moved-over text.
- R (replace) operator ([vimscript #5239](http://www.vim.org/scripts/script.php?script_id=5239)) provides an alternative
  implementation that defaults to the clipboard register.
- replace\_operator.vim ([vimscript #5742](http://www.vim.org/scripts/script.php?script_id=5742)) provides normal (only with motion,
  not by lines) and visual mode mappings.
- subversive.vim ([vimscript #5763](http://www.vim.org/scripts/script.php?script_id=5763)) provides another alternative
  implementation, has no default mappings, and as a unique feature provides a
  two-motion operator that changes all occurrences in the moved-over range
  with typed text; something similar to the functionality of my ChangeGlobally
  plugin ([vimscript #4321](http://www.vim.org/scripts/script.php?script_id=4321)).

USAGE
------------------------------------------------------------------------------

    [count]["x]gr{motion}   Replace {motion} text with the contents of register x.
                            Especially when using the unnamed register, this is
                            quicker than "_d{motion}P or "_c{motion}<C-R>"
    [count]["x]grr          Replace [count] lines with the contents of register x.
                            To replace from the cursor position to the end of the
                            line use ["x]gr$
    {Visual}["x]gr          Replace the selection with the contents of register x.

INSTALLATION
------------------------------------------------------------------------------

The code is hosted in a Git repo at
    https://github.com/inkarkat/vim-ReplaceWithRegister
You can use your favorite plugin manager, or "git clone" into a directory used
for Vim packages. Releases are on the "stable" branch, the latest unstable
development snapshot on "master".

This script is also packaged as a vimball. If you have the "gunzip"
decompressor in your PATH, simply edit the \*.vmb.gz package in Vim; otherwise,
decompress the archive first, e.g. using WinZip. Inside Vim, install by
sourcing the vimball or via the :UseVimball command.

    vim ReplaceWithRegister*.vmb.gz
    :so %

To uninstall, use the :RmVimball command.

### DEPENDENCIES

- Requires Vim 7.0 or higher.
- ingo-library.vim plugin ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)), version 1.038 or higher
  (optional).
- repeat.vim ([vimscript #2136](http://www.vim.org/scripts/script.php?script_id=2136)) plugin (optional)
  To support repetition with a register other than the default register, you
  need version 1.1 or later.
- visualrepeat.vim ([vimscript #3848](http://www.vim.org/scripts/script.php?script_id=3848)) plugin (version 2.00 or higher; optional)

CONFIGURATION
------------------------------------------------------------------------------

The default mappings override the (rarely used, but somewhat related) gr
command (replace virtual characters under the cursor with {char}).
If you want to use different mappings, map your keys to the
&lt;Plug&gt;ReplaceWithRegister... mapping targets _before_ sourcing the script
(e.g. in your vimrc):

    nmap <Leader>r  <Plug>ReplaceWithRegisterOperator
    nmap <Leader>rr <Plug>ReplaceWithRegisterLine
    xmap <Leader>r  <Plug>ReplaceWithRegisterVisual

LIMITATIONS
------------------------------------------------------------------------------

- The mode cannot be set for register "/; it will always be pasted
  characterwise. Implement a special case for glp?
- With :set selection=clipboard together with either "autoselect" (in the
  console) or a 'guioptions' setting that contains "a" (in the GUI), the
  mappings don't seem to work. This is because they all temporarily create a
  visual selection, whose contents are put into register \*, which is the
  default register due to the 'selection' setting. Therefore, the replacement
  replaces itself. The same happens when you try to replace the visual
  selection via the built-in v\_p command. Either don't use these settings in
  combination, or explicitly select the default register by prepending "" to
  the mappings.

### CONTRIBUTING

Report any bugs, send patches, or suggest features via the issue tracker at
https://github.com/inkarkat/vim-ReplaceWithRegister/issues or email (address
below).

HISTORY
------------------------------------------------------------------------------

##### 1.44    12-Nov-2024
- The gr custom operator doesn't clobber the previous visual selection any
  longer (if the optional ingo-library.vim ([vimscript #4433](http://www.vim.org/scripts/script.php?script_id=4433)) is installed).
- BUG: gr{motion} deletes one additional character when the moved-over text
  starts at the end of a line and 'virtualedit' is off. (Reported by
  sawogus29.) Need to temporarily :set virtualedit=onemore.

##### 1.43    19-Nov-2019
- BUG: {count}grr does not repeat the count.
- Suppress "--No lines in buffer--" message when replacing the entire buffer,
  and combine "Deleted N lines" / "Added M lines" into a single message that
  is given when either previous or new amount of lines reaches 'report'.

##### 1.42    29-Oct-2014
- BUG: Previous version 1.41 broke replacement of single character with
  gr{motion}.

##### 1.41    28-May-2014
- Also handle empty exclusive selection and empty text object
  (e.g. gri" on "").

##### 1.40    21-Nov-2013
- Avoid changing the jumplist.
- Use optional visualrepeat#reapply#VisualMode() for normal mode repeat of a
  visual mapping. When supplying a [count] on such repeat of a previous
  linewise selection, now [count] number of lines instead of [count] times the
  original selection is used.

##### 1.31    28-Nov-2012
- BUG: When repeat.vim is not installed, the grr and v\_gr mappings do nothing.
Need to :execute the :silent! call of repeat.vim to avoid that the remainder
of the command line is aborted together with the call. Thanks for David
Kotchan for reporting this.

##### 1.30    06-Dec-2011
- Adaptations for blockwise replace:
  - If the register contains just a single line, temporarily duplicate the
    line to match the height of the blockwise selection.
  - If the register contains multiple lines, paste as blockwise.
- BUG: v:register is not replaced during command repetition, so repeat always
  used the unnamed register. Add register registration to enhanced repeat.vim
  plugin, which also handles repetition when used together with the expression
  register "=. Requires a so far inofficial update to repeat.vim version 1.0
  (that hopefully makes it into upstream), which is available at
  https://github.com/inkarkat/vim-repeat/zipball/1.0ENH1
- Moved functions from plugin to separate autoload script.

##### 1.20    26-Apr-2011
- BUG: ReplaceWithRegisterOperator didn't work correctly with linewise motions
  (like "+"); need to use a linewise visual selection in this case.
- BUG: Text duplicated from yanked previous lines is inserted on a replacement
  of a visual blockwise selection. Switch replacement mechanism to a put in
  visual mode in combination with a save and restore of the unnamed register.
  This should handle all cases and doesn't require the autoindent workaround,
  neither.

##### 1.10    21-Apr-2011
- The operator-pending mapping now also handles 'nomodifiable' and 'readonly'
  buffers without function errors.
- Add experimental support for repeating the replacement also in visual mode
  through visualrepeat.vim. Renamed vmap &lt;Plug&gt;ReplaceWithRegisterOperator to
  &lt;Plug&gt;ReplaceWithRegisterVisual for that.

__PLEASE UPDATE YOUR CUSTOM MAPPINGS__
  A repeat in visual mode will now apply the previous line and operator
  replacement to the selection text. A repeat in normal mode will apply the
  previous visual mode replacement at the current cursor position, using the
  size of the last visual selection.

##### 1.03    07-Jan-2011
- ENH: Better handling when buffer is 'nomodifiable' or 'readonly'.
- Added separate help file and packaging the plugin as a vimball.

##### 1.02    25-Nov-2009
- Replaced the &lt;SID&gt;Count workaround with :map-expr and an intermediate
s:ReplaceWithRegisterOperatorExpression.

##### 1.01    06-Oct-2009
- Do not define "gr" mapping for select mode; printable characters should start
insert mode.

##### 1.00    05-Jal-2009
- First published version.

##### 0.01    11-Aug-2008
- Started development.

------------------------------------------------------------------------------
Copyright: (C) 2008-2024 Ingo Karkat -
The [VIM LICENSE](http://vimdoc.sourceforge.net/htmldoc/uganda.html#license) applies to this plugin.

Maintainer:     Ingo Karkat &lt;ingo@karkat.de&gt;
