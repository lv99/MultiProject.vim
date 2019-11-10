
let s:Creator = {}
let g:MProjCreator = s:Creator

function! s:Creator.New()
    let newCreator = copy(self)
    return newCreator
endfunction

function! s:Creator.BufferName()
    return 'B_MultiProject'
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

    setlocal nonumber
    setlocal norelativenumber

    iabc <buffer>

    setlocal cursorline

    "call self._setupStatusline()
	call mproj#bindMappings()

    setlocal filetype=mproj
endfunction


function! s:Creator._syntax()
	syntax clear
	syn match mprojTitle /MultiProject/
	syn match mprojNormal / - \h\+/
	syn match mprojError / × \h\+/
	hi def link mprojTitle Title
	hi def link mprojNormal Label
	hi def link mprojError Error
endfunction

function! s:Creator._createTreeWin()
    let l:splitLocation = g:MProjWinPos ==# 'left' ? 'topleft ' : 'botright '
    let l:splitSize = g:MProjWinSize

    let g:MProjBufName = self.BufferName()
    silent! execute l:splitLocation . 'vertical ' . l:splitSize . ' new'
    silent! execute 'edit ' . g:MProjBufName
    silent! execute 'vertical resize '. l:splitSize

    setlocal winfixwidth

    call self._setCommonBufOptions()
	call self._syntax()

endfunction

function! s:Creator.ToggleTabTree()
    let creator = s:Creator.New()
    call creator.toggleTabTree()
endfunction

function! s:Creator._isBufHidden(nr)
    redir => bufs
    silent ls!
    redir END
    return bufs =~ a:nr . '..h'
endfunction

function! s:Creator.toggleTabTree()
    if !g:MProj.IsOpen()
        call self._createTreeWin()
        call g:MProj.render()
        call g:MProjUI.restoreScreenState()
    else
        call g:MProj.Close()
    endif
endfunction


