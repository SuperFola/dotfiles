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
Plug 'airblade/vim-gitgutter'                         " git integration in editor
Plug 'luochen1990/rainbow'                            " rainbow parentheses improved
Plug 'dominikduda/vim_current_word'                   " highlight occurences of the current word
Plug 'wafelack/Ark.vim'                               " arkscript syntactic coloration
call plug#end()

" ----------------- plugins configuration ------------------
" nerdtree
let NERDTreeIgnore=['\.pyc$', '__pycache__', 'node_modules']
" autocmd vimenter * NERDTree                            " launch nerdtree automatically when vim starts
" airline
let g:airline#extensions#tabline#enabled = 1           " display all buffer in airline if we have only 1 tab
let g:airline#extensions#tabline#left_sep = ' '        " buffer separator
let g:airline#extensions#tabline#left_alt_sep = '|'    " alt buffer separator
" git gutter
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}
set updatetime=100
" rainbow
let g:rainbow_active = 1
" vim_current_word
let g:vim_current_word#highlight_twins = 1
let g:vim_current_word#highlight_current_word = 1
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
set listchars=tab:>-,trail:~,extends:>,precedes:< " display trailing characters
set list

syntax on


filetype plugin indent on

" max 80 chars per line
" set textwidth=80

" create a command 'WP'
" WordProcessorMode() being a function
" com! WP call WordProcessorMode()

" peachpuff, slate
colorscheme slate 
