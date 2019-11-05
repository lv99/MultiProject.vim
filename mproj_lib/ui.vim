
let s:UI = {}
let g:MProjUI = s:UI

function! s:UI.New(mproj)
    let newObj = copy(self)
    let newObj.mproj = a:mproj
    let newObj._showHelp = 0
    let newObj._ignoreEnabled = 1
    return newObj
endfunction

function! s:UI.render()
    setlocal noreadonly modifiable

    " remember the top line of the buffer and the current line so we can
    " restore the view exactly how it was
    let curLine = line(".")
    let curCol = col(".")
    let topLine = line("w0")

    " delete all lines in the buffer (being careful not to clobber a register)
    silent 1,$delete _

    call self._dumpHelp()

    " delete the blank line before the help and add one after it
    if !self.isMinimal()
        call setline(line(".")+1, "")
        call cursor(line(".")+1, col("."))
    endif

    " add the 'up a dir' line
    if !self.isMinimal()
        call setline(line(".")+1, s:UI.UpDirLine())
        call cursor(line(".")+1, col("."))
    endif

    " draw the header line
    "let header = self.nerdtree.root.path.str({'format': 'UI', 'truncateTo': winwidth(0)})
    call setline(line(".")+1, header)
    call cursor(line(".")+1, col("."))

    " draw the tree
    "silent put =self.nerdtree.root.renderToString()

    " delete the blank line at the top of the buffer
    silent 1,1delete _

    " restore the view
    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(topLine, 1)
    normal! zt
    call cursor(curLine, curCol)
    let &scrolloff = old_scrolloff

    setlocal readonly nomodifiable
endfunction

function! s:UI.restoreScreenState()
    if !has_key(self, '_screenState')
        return
    endif
    call mproj#exec("silent vertical resize " . self._screenState['oldWindowSize'], 1)

    let old_scrolloff=&scrolloff
    let &scrolloff=0
    call cursor(self._screenState['oldTopLine'], 0)
    normal! zt
    call setpos(".", self._screenState['oldPos'])
    let &scrolloff=old_scrolloff
endfunction

