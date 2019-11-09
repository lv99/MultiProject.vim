
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

function! s:MProjList.GetSelected()
	let index = line('.') - 2
	if index < 0
		return {}
	endif
	let config = g:MProjProjectList[index]
	return config
endfunction

function! s:MProjList.openProject()
	let config=self.GetSelected()
	if len(config) <= 0
		return
	endif
	exec 'cd ' . config['path']
	if exists("g:NERDTree")
		if !g:NERDTree.ExistsForBuf()
			NERDTree
		else
			NERDTreeCWD
		endif
	endif
endfunction
