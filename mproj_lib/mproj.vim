
let s:MProj = {}
let g:MProj = s:MProj

function! s:MProj.GetWinNum()
    if exists("g:MProjBufName")
        return bufwinnr(g:MProjBufName)
    endif
    return -1
endfunction

function! s:MProj.IsOpen()
    return s:MProj.GetWinNum() != -1
endfunction

function! s:MProj.Close()
    if !s:MProj.IsOpen()
        return
    endif
	exec 'bw ' . g:MProjBufName
	if exists("g:MProjBufName")
		unlet g:MProjBufName
    endif
endfunction

function! s:MProj.render()
    call g:MProjUI.render()
endfunction

