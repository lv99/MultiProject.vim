
let s:MProjList = {}
let g:MProjList = s:MProjList

function! s:MProjList.New(mproj)
    let newProjList = copy(self)
    let newProjList.children = []
    let newProjList._mproj = a:mproj
    return newProjList
endfunction

function! s:MProjList.getMProj()
    return self._mproj
endfunction

function! s:MProjList.renderToString()
    let output = ""
	for config in g:MProjProjectList
        let output = output . ' - ' . config['name'] . "\n"
	endfor
    return output
endfunction
