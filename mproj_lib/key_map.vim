
let s:KeyMap = {}
let g:MProjKeyMap = s:KeyMap
let s:keyMaps = {}


function! s:KeyMap.BindAll()
    for i in values(s:keyMaps)
        call i.bind()
    endfor
endfunction
