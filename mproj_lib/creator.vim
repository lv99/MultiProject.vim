
let s:Creator = {}
let g:MProjCreator = s:Creator

function! s:Creator.New()
    let newCreator = copy(self)
    return newCreator
endfunction

function! s:Creator._nextBufferNumber()
    if !exists("s:Creator._NextBufNum")
        let s:Creator._NextBufNum = 1
    else
        let s:Creator._NextBufNum += 1
    endif
    return s:Creator._NextBufNum
endfunction

function! s:Creator._nextBufferName()
    let name = s:Creator.BufNamePrefix() . self._nextBufferNumber()
    return name
endfunction

function! s:Creator.BufNamePrefix()
    return 'MProj_'
endfunction

function! s:Creator._bindMappings()
    call g:MProjKeyMap.BindAll()
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
	call self._bindMappings()

    setlocal filetype=mproj
endfunction


function! s:Creator._createTreeWin()
    let l:splitLocation = g:MProjWinPos ==# 'left' ? 'topleft ' : 'botright '
    let l:splitSize = g:MProjWinSize

    if !g:MProj.ExistsForTab()
        let t:NERDTreeBufName = self._nextBufferName()
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' new'
        silent! execute 'edit ' . t:NERDTreeBufName
        silent! execute 'vertical resize '. l:splitSize
    else
        silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' split'
        silent! execute 'buffer ' . t:NERDTreeBufName
    endif

    setlocal winfixwidth

    call self._setCommonBufOptions()

    endif

endfunction

function! s:Creator.ToggleTabTree(dir)
    let creator = s:Creator.New()
    call creator.toggleTabTree(a:dir)
endfunction

function! s:Creator.CreateTabTree()
    let creator = s:Creator.New()
    call creator.createTabTree()
endfunction

function! s:Creator.createTabTree()
    call self._broadcastInitEvent()
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


