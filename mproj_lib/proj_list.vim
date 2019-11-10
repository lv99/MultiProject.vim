
let s:MProjList = {}
let g:MProjList = s:MProjList

let g:MProjCurrentConfig = {}

function! s:MProjList.renderToString()
    let output = ''
	for config in g:MProjProjectList
		if isdirectory(config['path'])
        	let output = output . ' - ' . config['name'] . "\n"
		else
        	let output = output . ' × ' . config['name'] . "\n"
		endif
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

function! s:MProjList.doOpenCallback(config)
	if !has_key(a:config,'open')
		return
	endif
	try
		call a:config['open']()
	catch
		call mproj#echo('fail to exec ' . a:config['name'] . ' open function')
	endtry
endfunction

function! s:MProjList.doCloseCallback(config)
	if !has_key(a:config,'close')
		return
	endif
	try
		call a:config['close']()
	catch
		call mproj#echo('fail to exec ' . a:config['name'] . ' close function')
	endtry
endfunction

function! s:MProjList.openProject()
	let config=self.GetSelected()
	if len(config) <= 0
		return
	endif
	if !isdirectory(config['path'])
		if len(config['path'])<=0
			return
		endif
		let prompt = g:MProj.inputPrompt('create') . config['path'] .'(yN):'
		let choice = input(prompt)
		if choice !=# 'y'
			return
		endif
		try
			exec 'silent !mkdir ' . config['path']
		catch
			call mproj#echo('path not created.')
		endtry
	endif
	if len(g:MProjCurrentConfig)>0
		call self.doCloseCallback(g:MProjCurrentConfig)
	endif
	let g:MProjCurrentConfig = config
	exec 'cd ' . config['path']
	call self.doOpenCallback(g:MProjCurrentConfig)
	if g:MProjAutoHide
		call g:MProj.Close()
	endif
	if exists('g:NERDTree')
		if !g:NERDTree.ExistsForBuf()
			NERDTree
		else
			NERDTreeCWD
		endif
	endif
endfunction

function! s:MProjList.openProjectInExplorer()
	let config=self.GetSelected()
	if len(config) <= 0
		return
	endif
	if !isdirectory(config['path'])
		return
	endif
	exec '!start explorer ' . config['path'] . ',%:p'
endfunction
