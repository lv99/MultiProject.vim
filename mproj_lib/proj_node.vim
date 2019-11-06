
let s:ProjectNode = {}
let g:MProjNode = s:ProjectNode

function! s:ProjectNode.New(name, mproj)
    let newProjNode = copy(self)
    let newProjNode.name = a:name
    let newProjNode.parent = {}
    let newProjNode._mproj = a:mproj
    return newProjNode
endfunction
