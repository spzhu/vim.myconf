set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tmhedberg/SimpylFold'
" Plugin 'vim-scripts/Pydiction'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'nvie/vim-flake8'
Plugin 'jnurmine/Zenburn'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'
Plugin 'tomasr/molokai'
Plugin 'sickill/vim-monokai'
" Plugin 'davidhalter/jedi-vim'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
" An example for a vimrc file.
"
set splitbelow
set splitright
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap " ""<Esc>i
inoremap ' ''<Esc>i
inoremap < <><Esc>i

" python with virtualenv support
python3 << EOF
import vim
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate')
    os.system(". "+activate_this)
EOF

"syntastic configration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_ignore_files=[".*\.py$"]

"nerdtree configuration
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
autocmd vimenter * NERDTree
wincmd w
autocmd VimEnter * wincmd w
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-t> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" SimpylFold
let g:SimpylFold_docstring_preview=1
" Enable folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" PEP8 style for python file
au BufNewFile,BufRead *.py
\set tabstop=4
\ set softtabstop=4
\ set shiftwidth=4
\ set textwidth=79
\ set expandtab
\ set autoindent
\ set fileformat=unix
" syntastic PEP8 check
let python_highlight_all=1
syntax on

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
highlight BadWhitespace ctermbg=red guibg=red

let g:flake8_quickfix_location="topleft"
let g:flake8_quickfix_height=7

"Pydiction
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" YouCompleteMe
set runtimepath+=~/.vim/bundle/YouCompleteMe
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files = 1           
let g:syntastic_ignore_files=[".*\.py$"]
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax = 1                  
let g:ycm_confirm_extra_conf = 0
" 映射按键, 没有这个会拦截掉tab, 导致其他插件的tab不能用.
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']  
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']
" 在注释输入中也能补全
let g:ycm_complete_in_comments = 1                          
" 在字符串输入中也能补全
let g:ycm_complete_in_strings = 1                           
" 注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" 禁用语法检查
let g:ycm_show_diagnostics_ui = 0                           
" 回车即选中当前项
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" |            
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2                 


" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set backup		" do not keep a backup file, use versions instead
"else
set nobackup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set swapfile
set undodir=~/.undodir
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse-=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


syntax enable
if has('gui_running')
  colorscheme monokai
else
  colorscheme monokai
endif

set nu
set encoding=utf-8
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

"highlight cusor column line
set cursorcolumn
hi CursorColumn cterm=NONE ctermbg=black ctermfg=NONE guibg=darkred guifg=white
set cursorline
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE guibg=darkred guifg=white
" 设置补全窗口颜色
hi Pmenu ctermfg=black ctermbg=gray guibg=#444444
" hi PmenuSel ctermfg=7 ctermbg=4 guibg=#555555 guifg=#ffffff
" 查看方法输入:Man api_name
" source $VIMRUNTIME/ftplugin/man.vim
" " 映射之后就可以少按一下 Shift 键。
" cmap man Man
" " 在普通模式下按下 K （大写）即可启动 man 查看光标下的函数。
" nmap K :Man <cword><CR>
