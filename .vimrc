" install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif

" load vim-plug
call plug#begin()
Plug 'flazz/vim-colorschemes'                         " change colorscheme with :colors name
Plug 'scrooloose/nerdtree' , {'on': 'NERDTreeToggle'} " proper file explorer inside vim
Plug 'vim-airline/vim-airline'                        " better status line
call plug#end()

" ----------------- plugins configuration ------------------
let NERDTreeIgnore=['\.pyc$', '__pycache__', 'node_modules']
" ----------------- plugins config end    ------------------

set expandtab               " expand tabs into spaces
set tabstop=4               " tab = 4 spaces
set softtabstop=4           " act like they are tabs not spaces
set shiftwidth=4            " indentation
set scrolloff=10            " scroll offset below/above cursor
set wildmenu                " tab command completion in vim
set ignorecase              " ignore case while searching
set autoindent              " let's give this another try
set smartindent
set relativenumber          " relative lines numbering (current is 0)
set number                  " hybrid mode when used with rnu
set nowrap                  " don't wrap statements
set laststatus=2            " show status line even for 1 file
set mouse=nv                " allow mouse in normal and visual modes

syntax on


filetype plugin indent on

" max 80 chars per line
" set textwidth=80

" create a command 'WP'
" WordProcessorMode() being a function
" com! WP call WordProcessorMode()

" peachpuff, slate
colorscheme slate 
