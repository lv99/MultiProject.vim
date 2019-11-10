### MultiProject.vim
A simple multi project manager

<img src="https://github.com/lv99/MultiProject.vim/raw/master/usage.gif"> 

### Installation

Install with vim-plug or vundle

### Usage

1. Add a mproj section to your '~/.vimrc'
1. Add your projects to the 'g:MProjProjectList'
1. Call the command 'MProjToggle' to show project list.
1. Click 'o' to open the selected project.

#### Example

```vim

function! OpenVimrc()
	" do something when opening 'vimrc' project
	echo 'opening vimrc'
endfunction

function! CloseVimrc()
	" do something when closing 'vimrc' project 
	echo 'closing vimrc'
endfunction

" Specify names and paths for your projects
" Use the 'open' key to specify the callback function when opening the project
" Use the 'close' key to specify the callback function when closing the project
let g:MProjProjectList = [
	\{
		\'name':'vimrc',
		\'path':'C:\Users\lv99\.vim',
		\'open': function('OpenVimrc'),
		\'close': function('CloseVimrc'),
	\},
	\{
		\'name':'mproj',
		\'path':'C:\Users\lv99\.vim\plugged\MultiProject.vim',
	\},
	\]

" Key map to toggle the window.
nmap <F2> :MProjToggle <CR>
```

Reload .vimrc and `:MProjToggle` to open the window.

### Commands
| Command                             | Description                                                        |
| ----------------------------------- | ------------------------------------------------------------------ |
| `MProjToggle` | Open/close project list.                                                    |

### Global options
| Flag                | Default                           | Description                                            |
| ------------------- | --------------------------------- | ------------------------------------------------------ |
| `g:MProjWinPos`    | left                                | Default windows position                       |
| `g:MProjWinSize`    | 31                                | Default windows size                       |
| `g:MProjProjectList`    | []                                | Specify names and paths for your projects                     |
| `g:MProjAutoHide`    | 1                                | Default to close the MProj window after opening project                      |

### Keybindings

- 'o' - Open project
- 'Ctrl-o' -Open project directory in Windows File Explorer 
### License

MIT



