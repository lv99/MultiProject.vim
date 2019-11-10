
if exists("g:loaded_mproj_autoload")
    finish
endif
let g:loaded_mproj_autoload = 1

function! mproj#exec(cmd, ignoreAll)
    let old_ei = &ei
    if a:ignoreAll
        set ei=all
    endif
    exec a:cmd
    let &ei = old_ei
endfunction

function! mproj#loadClassFiles()
	runtime mproj_lib/mproj.vim
	runtime mproj_lib/creator.vim
	runtime mproj_lib/ui.vim
	runtime mproj_lib/proj_list.vim
endfunction

function! mproj#setupUICommands()
    command! -n=? -complete=dir -bar MProjToggle :call g:MProjCreator.ToggleTabTree()
endfunction

function! mproj#bindMappings()
	nnoremap <buffer> <silent> o : call g:MProjList.openProject()<CR>
	nnoremap <buffer> <silent> <leader>o : call g:MProjList.openProjectInExplorer()<CR>
endfunction 

function! mproj#echo(msg)
    redraw
    echomsg empty(a:msg) ? "" : ("MulitProject: " . a:msg)
endfunction
