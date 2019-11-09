
let s:Creator = {}
let g:MProjCreator = s:Creator

function! s:Creator.New()
    let newCreator = copy(self)
    return newCreator
endfunction

function! s:Creator.BufferName()
    return 'MProj'
endfunction

function! s:Creator._setCommonBufOptions()

    " Options for a non-file/control buffer.
    setlocal bufhidden=hide
    setlocal buftype=nofile
    setlocal noswapfile

    " Options for controlling buffer/window appearance.
    setlocal foldcolumn=0
    setlocal foldmethod=manual
    setlocal nobuflisted
    setlocal nofoldenable
    setlocal nolist
    setlocal nospell
    setlocal nowrap

    setlocal nonu
    setlocal nornu

    iabc <buffer>

    "if g:MProjHighlightCursorline
        setlocal cursorline
    "endif

    "call self._setupStatusline()
	call mproj#bindMappings()

    setlocal filetype=mproj
endfunction


function! s:Creator._createTreeWin()
    let l:splitLocation = g:MProjWinPos ==# 'left' ? 'topleft ' : 'botright '
    let l:splitSize = g:MProjWinSize

    if !g:MProj.ExistsForTab()
        let t:NERDTreeBufName = self.BufferName()
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' new'
        silent! execute 'edit ' . t:NERDTreeBufName
        silent! execute 'vertical resize '. l:splitSize
    else
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' split'
        silent! execute 'buffer ' . t:NERDTreeBufName
    endif

    setlocal winfixwidth

    call self._setCommonBufOptions()

endfunction

function! s:Creator.ToggleTabTree()
    let creator = s:Creator.New()
    call creator.toggleTabTree()
endfunction

function! s:Creator.CreateTabTree()
    let creator = s:Creator.New()
    call creator.createTabTree()
endfunction

function! s:Creator._isBufHidden(nr)
    redir => bufs
    silent ls!
    redir END
    return bufs =~ a:nr . '..h'
endfunction

function! s:Creator._removeTreeBufForTab()
    let buf = bufnr(t:MProjBufName)
    if buf != -1
        if self._isBufHidden(buf)
            exec "bwipeout " . buf
        endif

    endif
    unlet t:MProjBufName
endfunction

function! s:Creator._createMProj()
    let b:MProj = g:MProj.New()

    let b:MProjRoot = b:MProj.root

endfunction

function! s:Creator.createTabTree()
    if g:MProj.ExistsForTab()
        call g:MProj.Close()
        call self._removeTreeBufForTab()
    endif

    call self._createTreeWin()
    call self._createMProj()
    call b:MProj.render()

endfunction

function! s:Creator.toggleTabTree()
	if g:MProj.ExistsForTab()
        if !g:MProj.IsOpen()
            call self._createTreeWin()
            if !&hidden
                call b:MProj.render()
            endif
            call b:MProj.ui.restoreScreenState()
        else
            call g:MProj.Close()
        endif
    else
        call self.createTabTree()
    endif
endfunction


