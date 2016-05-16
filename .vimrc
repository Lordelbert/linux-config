" An example for a vimrc file.
"
" Original from:	Bram Moolenaar <Bram@vim.org>
" Maintainer: MADAU
"

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set backup		" keep a backup file (restore to previous version)
set undofile		" keep an undo file (undo changes after closing)
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set autoindent
set number
set smarttab
set shiftwidth=4
set tabstop=4
let g:solarized_termcolors=256
"set background=dark
syntax enable
colorscheme solarized
"background and tmux require this:
set t_ut=

" ----- leader related   -----
"change leader for ,
":let mapleader = ","
" spell checking ,ss on and off
map <leader>ss :setlocal spell!<cr>
map <leader>c  :let @/ = ""
" ----- end leader stuff -----

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

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

" ---- Plugin Section using vim-plug ----
"
call plug#begin('~/.vim/plugged')

" lateX plug-in
Plug 'https://github.com/vim-latex/vim-latex.git'
" Plug 'https://github.com/LaTeX-Box-Team/LaTeX-Box.git'

" Nerdtre + plugin for nerdtree
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/jistr/vim-nerdtree-tabs.git'

" status bar
Plug 'https://github.com/itchyny/lightline.vim'

"syntax check
Plug 'https://github.com/scrooloose/syntastic.git'

" -- rust section: --
" syntax color 
Plug 'https://github.com/wting/rust.vim.git'
" racer
Plug 'https://github.com/racer-rust/vim-racer.git'
" -- end rust --

call plug#end()

let g:nerdtree_tabs_open_on_console_startup=1

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
" set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

"syntax checker set
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
"Racer rust
set hidden
let g:racer_cmd = "/home/maxime/utilitaire/racer/target/release/racer"
let $RUST_SRC_PATH="/home/maxime/utilitaire/rust/src/"
