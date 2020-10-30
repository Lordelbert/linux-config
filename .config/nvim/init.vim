set nocompatible
filetype indent plugin on
syntax on
set hidden
set wildmenu
set showcmd
set hlsearch
set encoding=UTF-8
set ignorecase
set smartcase
set backspace=indent,eol,start
set autoindent
set nostartofline
set ruler
set cursorline
set laststatus=2
set visualbell
set mouse=a
" Autobackup
set backup
set backupdir=~/.backup/
set writebackup
set backupcopy=yes
au BufWritePre * let &bex = '@' . strftime("%F.%H:%M")
filetype plugin on
"set list
"set listchars=tab:\\|\
set cmdheight=1
set number relativenumber
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
highlight EndOfBuffer ctermfg=black ctermbg=black
"-----------------------------------------------------------
" Indentation options
set softtabstop=0 noexpandtab
set shiftwidth=4
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

"-----------------------------------------------------------
" Plugin
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'liuchengxu/vim-clap'
Plug 'kaicataldo/material.vim'
Plug 'https://github.com/octol/vim-cpp-enhanced-highlight.git'

Plug 'https://github.com/itchyny/vim-gitbranch.git'
Plug 'https://github.com/airblade/vim-gitgutter.git'
"Grammar
Plug 'https://github.com/dpelle/vim-Grammalecte.git'
Plug 'https://github.com/rhysd/vim-grammarous.git'
"Programming
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/sbdchd/neoformat.git'
Plug 'https://github.com/petRUShka/vim-opencl.git'
Plug 'https://github.com/vim-scripts/buftabs.git'
"kikoo
Plug 'aurieh/discord.nvim', { 'do': ':UpdateRemotePlugins'}
call plug#end()

set t_ZH=^[[3m
set t_ZR=^[[23m

set termguicolors
set background=dark
let g:material_theme_style = 'darker'
colorscheme material

"-----------------------------------------------------------
" Shortcuts
noremap <silent> <C-E> :call ToggleNetrw()<CR>
tnoremap <Esc> <C-\><C-n>
let mapleader=','
nnoremap <C-L> :nohl<CR><C-L>
noremap <C-n> <C-\><C-N>
map <C-c> :let @/ =""<cr>
map <C-s> :set listchars=tab:\\|\ <cr>
"json pretty
map <C-j> :%!jq .<cr>
map <C-j><C-c> :%!jq -c .<cr>
"hex pretty
map <C-x> :%!xxd<cr>
map <C-f> :call Find_file()<CR>
function! Find_file() abort
  Clap files ++finder=rg --ignore --hidden --files
endfunction
noremap <C-h> :bprev<CR>
noremap <C-l> :bnext<CR>
" cscope
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
nmap <C-f>s :tab scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-f>g :tab scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-f>c :tab scs find c <C-R>=expand("<cword>")<CR><CR>
"nmap <C-f>t :tab scs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <C-f>e :tab scs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <C-f>f :tab scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-f>i :tab scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-f>d :tab scs find d <C-R>=expand("<cword>")<CR><CR>

" LSP
nnoremap <silent> <C-d> :call LanguageClient_textDocument_definition()      <CR>
nnoremap <silent> <C-t> :call LanguageClient_textDocument_hover()           <CR>
nnoremap <silent> <C-n> :call LanguageClient#textDocument_rename()          <CR>
nnoremap <silent> <C-s> :call LanguageClient#textDocument_documentSymbol()  <CR>
"nnoremap <silent> <C-f> :call LanguageClient#textDocument_codeAction()      <CR>

"------------------------------------------------------------
" Lightline
let g:lightline#bufferline#show_number  = 1
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }
"let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
"let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
"let g:lightline.component_type   = {'buffers': 'tabsel'}
"set showtabline=2

"------------------------------------------------------------
" deoplete + neoformat
let g:deoplete#enable_at_startup = 1
let g:neoformat_enabled_go = ['gofmt']
"let g:neoformat_enabled_cpp = ['clang-format']
"let g:neoformat_enabled_c = ['clang-format']
let g:neoformat_c_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style=file'],
            \ }
let g:neoformat_cpp_clangformat = {
            \ 'exe': 'clang-format',
            \ 'args': ['-style=file'],
            \ }
let g:neoformat_enabled_rust = ['rustfmt']
let g:neoformat_enabled_python = ['autopep8']

"------------------------------------------------------------
" LSP
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'c': ['clangd'],
  \ 'rust': ['rustup', 'run', 'stable', 'rls'],
  \ 'go': ['~/utilitaire/go/bin/gopls'],
  \ 'tex' : ['texlab'],
  \ 'zig' : ['zig-lsp'],
  \ 'f90' : ['fortls'],
  \ }
let g:LanguageClient_autoStart = 1
"let g:LanguageClient_diagnosticsList = "Location"
let g:vista_default_executive = 'lcn'
"let g:vista_fzf_preview = ['right:50%']
let g:vista_sidebar_width=40
let g:grammalecte_cli_py='~/utilitaire/Grammalecte/pythonpath/grammalecte-cli.py'

"-----------------------------------------------------------
"netrw stuff
let g:netrw_liststyle=3
let g:netrw_banner = 0
"    1 - open files in a new horizontal split
"    2 - open files in a new vertical split
"    3 - open files in a new tab
"    4 - open in previous window
let g:netrw_browse_split = 3
let g:netrw_winsize = 20
let g:NetrwIsOpen=0

function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction
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

"  command -nargs=0 Cscope cs add $VIMSRC/src/cscope.out $VIMSRC/src
  """"""""""""" Standard cscope/vim boilerplate

  " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
  set cscopetag

  " check cscope for definition of a symbol before checking ctags: set to 1
  " if you want the reverse search order.
  set csto=0
  " show msg when any other cscope db added
  set cscopeverbose
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
" Code format
set colorcolumn=95
"highlight ColorColum ctermbg=Black ctermfg=DarkRed
" Highlight trailing spaces
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
set splitbelow splitright
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
nnoremap <CR> :noh<CR><CR>

