### MultiProject.vim
a simple multi project manager

<img src="https://raw.githubusercontent.com/lv99/i/master/MultiProject.vim/usage.gif" height="450"> 

### Installation

Install with vim-plug or vundle

### Usage

1. Add a mproj section to your '~/.vimrc'
1. Add your projects to the 'g:MProjProjectList'
1. Call the command 'MProjToggle' to show the project list.
1. Click 'o' to open the selected project.

#### Example

```vim

" Specify names and paths for your projects
let g:MProjProjectList = [
	\{
		\'name':'vimrc',
		\'path':'C:\Users\lv99\.vim',
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
| `MProjToggle` | Open/close the project list.                                                    |

### Global options
| Flag                | Default                           | Description                                            |
| ------------------- | --------------------------------- | ------------------------------------------------------ |
| `g:MProjWinPos`    | left                                | Default windows position                       |
| `g:MProjWinSize`    | 31                                | Default windows size                       |
| `g:MProjProjectList`    | []                                | Specify names and paths for your projects                     |
| `g:MProjAutoHide`    | 1                                | Default to close the MProj window after opened project                      |

### Keybindings

- 'o' - Open the project

### License

MIT



