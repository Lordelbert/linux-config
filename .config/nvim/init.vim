set nocompatible
filetype indent plugin on
syntax on
"------------------------------------------------------------
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
set encoding=UTF-8

"------------------------------------------------------------
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set laststatus=2
"set confirm
set visualbell
" Enable use of the mouse for all modes
set mouse=a
filetype plugin on
set list
set listchars=tab:\\|\ 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=1
set number
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
let g:lightline = { 'colorscheme': 'nord',}
let g:nord_uniform_status_lines = 1
let g:nord_comment_brightness = 12
colorscheme nord
"------------------------------------------------------------
" Indentation options {{{1
set shiftwidth=4
set softtabstop=4
set expandtab

"------------------------------------------------------------
" Mappings {{{1
let mapleader=','
nnoremap <C-L> :nohl<CR><C-L>
map <leader>c :let @/ =""
map <leader>s :set listchars=tab:\\|\ 
nmap <F8> :TagbarToggle<CR>
map <C-K> :py3f /usr/share/vim/addons/syntax/clang-format.py<cr>
"------------------------------------------------------------
"Cscope mapping
if has('cscope')

  set cscopetag cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
  endif

  cnoreabbrev csa cs add
  cnoreabbrev csf cs find
  cnoreabbrev csk cs kill
  cnoreabbrev csr cs reset
  cnoreabbrev css cs show
  cnoreabbrev csh cs help

  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
  """"""""""""" Standard cscope/vim boilerplate

  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
  set csto=0
  " show msg when any other cscope db added
  set cscopeverbose 
  " The following maps all invoke one of the following cscope search types:
  "
  "   's'   symbol: find all references to the token under cursor
  "   'g'   global: find global definition(s) of the token under cursor
  "   'c'   calls:  find all calls to the function name under cursor
  "   't'   text:   find all instances of the text under cursor
  "   'e'   egrep:  egrep search for the word under cursor
  "   'f'   file:   open the filename under cursor
  "   'i'   includes: find files that include the filename under cursor
  "   'd'   called: find functions that function under cursor calls
  "
  nmap <C-f>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-f>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-f>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-f>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-f>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-f>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-f>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-f>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif
cnoreabbrev <expr> csa
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
    cnoreabbrev <expr> csf
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
    cnoreabbrev <expr> csk
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs kill' : 'csk')
    cnoreabbrev <expr> csr
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs reset' : 'csr')
    cnoreabbrev <expr> css
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs show' : 'css')
    cnoreabbrev <expr> csh
          \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs help' : 'csh')

"------------------------------------------------------------
"Kernel Dev formating
"set colorcolumn=81
"highlight ColorColum ctermbg=Black ctermfg=DarkRed
" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

"-------------------------------------------------------------
" OmniCppCompletion plugin
"-------------------------------------------------------------

" Enable OmniCompletion
" http://vim.wikia.com/wiki/Omni_completion
set omnifunc=syntaxcomplete#Complete

" Configure menu behavior
" http://vim.wikia.com/wiki/VimTip1386
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
  \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
  \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Use Ctrl+Space for omni-completion
" http://stackoverflow.com/questions/510503/ctrlspace-for-omni-and-keyword-completion-in-vim
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
  \ "\<lt>C-n>" :
  \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
  \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
  \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" enable global scope search
let OmniCpp_GlobalScopeSearch = 1
" show function parameters
let OmniCpp_ShowPrototypeInAbbr = 1
" show access information in pop-up menu
let OmniCpp_ShowAccess = 1
" auto complete after '.'
let OmniCpp_MayCompleteDot = 1
" auto complete after '->'
let OmniCpp_MayCompleteArrow = 1
" auto complete after '::'
let OmniCpp_MayCompleteScope = 1
" don't select first item in pop-up menu
let OmniCpp_SelectFirstItem = 0

call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'LaTeX-Box-Team/LaTeX-Box'
Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git'
Plug 'https://github.com/arcticicestudio/nord-vim.git'
Plug 'https://github.com/dpelle/vim-Grammalecte.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/rhysd/vim-grammarous.git'
call plug#end()
"let g:deoplete#enable_at_startup= 1
le:grammalecte_cli_py='~/utilitaire/Grammalecte/pythonpath/grammalecte-cli.py'
