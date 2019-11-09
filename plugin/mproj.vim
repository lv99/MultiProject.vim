
if exists("loaded_mproj")
    finish
endif
let loaded_mproj = 1

function! s:initVariable(var, value)
    if !exists(a:var)
        exec 'let ' . a:var . ' = ' . "'" . substitute(a:value, "'", "''", "g") . "'"
        return 1
    endif
    return 0
endfunction

call s:initVariable("g:MProjWinPos", "left")
call s:initVariable("g:MProjWinSize", 31)
call s:initVariable("g:MProjProjectList", [])
call s:initVariable("g:MProjAutoHide", 1)

call mproj#loadClassFiles()
call mproj#setupUICommands()
