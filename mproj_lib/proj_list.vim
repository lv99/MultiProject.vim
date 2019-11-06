
let s:ProjectList = {}
let g:MProjList = s:ProjectList

function! s:ProjectList.New(mproj)
    let newProjList = copy(self)
    let newProjList.children = []
    let newProjList._mproj = a:mproj
    return newProjList
endfunction

function! s:MProjList.open(...)
    let l:numChildrenCached = 0
    if empty(self.children)
        let l:numChildrenCached = self._initChildren(0)
    endif

    return l:numChildrenCached
endfunction

function! s:MProjList._initChildren(silent)
    "remove all the current child nodes
    let self.children = []

    let files = self._glob('*', 1) + self._glob('.*', 0)

    let invalidProjectsFound = 0
    for i in files
        try
            let path = g:NERDTreePath.New(i)
            call self.createChild(path, 0)
            call g:NERDTreePathNotifier.NotifyListeners('init', path, self.getNerdtree(), {})
        catch /^NERDTree.\(InvalidArguments\|InvalidFiletype\)Error/
            let invalidProjectsFound += 1
        endtry
    endfor

    call self.sortChildren()

    call mproj#echo("")

    if invalidProjectsFound
        call mproj#echoWarning(invalidProjectsFound . " project(s) could not be loaded into the MultiProject")
    endif
    return self.getChildCount()
endfunction

