
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

    " call self._dumpHelp()

    " draw the header line
    let header = "MultiProject"
	call setline(line(".")+1, header)
    call cursor(line(".")+1, col("."))

    " draw the tree
    silent put =self.mproj.root.renderToString()

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


function! s:UI.getLineNum(node)

    if a:node.isRoot()
        return self.getRootLineNum()
    endif

    let l:pathComponents = [substitute(self.nerdtree.root.path.str({'format': 'UI'}), '/\s*$', '', '')]
    let l:currentPathComponent = 1

    let l:fullPath = a:node.path.str({'format': 'UI'})

    for l:lineNumber in range(self.getRootLineNum() + 1, line('$'))
        let l:currentLine = getline(l:lineNumber)
        let l:indentLevel = self._indentLevelFor(l:currentLine)

        if l:indentLevel != l:currentPathComponent
            continue
        endif

        let l:currentLine = self._stripMarkup(l:currentLine)
        let l:currentPath =  join(l:pathComponents, '/') . '/' . l:currentLine

        " Directories: If the current path "starts with" the full path, then
        " either the paths are equal or the line is a cascade containing the
        " full path.
        if l:fullPath[-1:] == '/' && stridx(l:currentPath, l:fullPath) == 0
            return l:lineNumber
        endif

        " Files: The paths must exactly match.
        if l:fullPath ==# l:currentPath
            return l:lineNumber
        endif

        " Otherwise: If the full path starts with the current path and the
        " current path is a directory, we add a new path component.
        if stridx(l:fullPath, l:currentPath) == 0 && l:currentPath[-1:] == '/'
            let l:currentLine = substitute(l:currentLine, '/\s*$', '', '')
            call add(l:pathComponents, l:currentLine)
            let l:currentPathComponent += 1
        endif
    endfor

    return -1
endfunction

