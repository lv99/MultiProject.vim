
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
	runtime mproj_lib/key_map.vim
	runtime mproj_lib/ui.vim
endfunction

function! mproj#setupUICommands()
    command! -n=? -complete=dir -bar MProjToggle :call g:MProjCreator.ToggleTabTree()
endfunction

