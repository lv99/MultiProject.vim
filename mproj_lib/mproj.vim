
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

    if winnr("$") != 1
        let l:useWinId = exists('*win_getid') && exists('*win_gotoid')

        if winnr() == s:MProj.GetWinNum()
            call mproj#exec("wincmd p", 1)
            let l:activeBufOrWin = l:useWinId ? win_getid() : bufnr("")
            call mproj#exec("wincmd p", 1)
        else
            let l:activeBufOrWin = l:useWinId ? win_getid() : bufnr("")
        endif

        call mproj#exec(s:MProj.GetWinNum() . " wincmd w", 1)
        call mproj#exec("close", 0)
        if l:useWinId
            call mproj#exec("call win_gotoid(" . l:activeBufOrWin . ")", 0)
        else
            call mproj#exec(bufwinnr(l:activeBufOrWin) . " wincmd w", 0)
        endif
    else
        close
    endif
endfunction

function! s:MProj.render()
    call g:MProjUI.render()
endfunction

