
let s:UI = {}
let g:MProjUI = s:UI

function! s:UI.render()
    setlocal noreadonly modifiable

    let curLine = line(".")
    let curCol = col(".")
    let topLine = line("w0")

    silent 1,$delete _

    let header = " MultiProject "
	call setline(line(".")+1, header)
    call cursor(line(".")+1, col("."))

    silent put =g:MProjList.renderToString()

    silent 1,1delete _

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

