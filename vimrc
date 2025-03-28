""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""PLUG-INS""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set up the vim-plug plugin manager
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'damonkelley/vim-python-syntax'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/fzf', { 'dir': '~/.fzf'}
Plug 'junegunn/fzf.vim'
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
Plug 'nvie/vim-flake8'
Plug 'vim-syntastic/syntastic'

if has('nvim')
    Plug 'Shougo/deoplete.nvim'
    Plug 'zchee/deoplete-jedi'
    Plug 'wokalski/autocomplete-flow'
endif

call plug#end()

" Set deoplete to auto start for auto-completion
if has('nvim')
    let g:deoplete#enable_at_startup = 1
endif


let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": [],
    \ "passive_filetypes": [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_python_checkers = ["flake8"]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""GENERAL SETTINGS"""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the Python intepreter locations (so neovim works fine within virtualenvs
let g:python_host_prog = "/usr/bin/python2.7"
let g:python3_host_prog = "/usr/bin/python3"

" Set VI compatibility off. Allows full VIM feature set.
set nocompatible

" Sets VIM to load plugins from .vim/plug-ins and .vimrc on startup
set loadplugins

filetype plugin on

" Show crosshair highlighting (line row and column)
set cursorline
set cursorcolumn

" Show relative line numbers and absolute line number for current line
set relativenumber
set number

" Allow switching buffers if there are unsaved changes in the current one
set hidden

" Show prompt to save if you try exiting a modified buffer before saving
set confirm

" Set vim to use syntax highlighting as well as automatic indentation
syntax on

" Make all indent commands ('>>' or '<<') a multiple of shiftwidth
set shiftround

" Sets the bottom right status line to show mode, position, and commands
set laststatus=2
set ruler
set showmode
set showcmd

" Sets the update time option to be much faster
set updatetime=100

" Sets the timout len (ms) for key combos such as remaps and key combos
set timeout
set timeoutlen=300

" Set default indentation
set autoindent

" Set search to be case insensitive UNLESS the search term has capitalization
set ignorecase
set smartcase

" Set status line with fugitive git branch indicator
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set t_Co=256
colorscheme gruvbox
set background=dark

if has('nvim')
    set mouse+=a
endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""AUTOCOMMANDS"""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set Python autocommands
augroup python
    autocmd!
    " The code below would eliminate spaces right before an endline character
    " with each save.
    " autocmd BufWritePre * %s/\s\+$//e
    autocmd FileType python setlocal colorcolumn=80,99 textwidth=99 expandtab shiftwidth=4 tabstop=4 softtabstop=4 autoindent
augroup END

" Set HTML defaults
augroup html
    autocmd!
    autocmd FileType html,htmldjango setlocal textwidth=120 shiftwidth=2 tabstop=2 softtabstop=2 autoindent
augroup END

" Set XML/XSD defaults
augroup xml-xsd
    autocmd!
    autocmd BufNewFile,BufRead *.xsd set filetype=xml
    autocmd FileType xml setlocal textwidth=120 shiftwidth=2 tabstop=2 softtabstop=2 autoindent
augroup END

" Set Markdown/ReStructured Text defaults
augroup md-rst
    autocmd!
    autocmd BufNewFile,BufRead *.md set filetype=markdown
    autocmd FileType markdown setlocal textwidth=120 shiftwidth=4 tabstop=4 softtabstop=4 autoindent
augroup END

" Immediately enter insert mode when entering a terminal buffer
if has('nvim')
    augroup terminals
        autocmd!
        autocmd TermOpen * startinsert
    augroup END
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""KEY BINDINGS"""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets certain remaps
inoremap jk <esc>
inoremap <esc> <nop>

" Sets the leader key to space
let mapleader = "\<Space>"

"Sets <leader>[hjkl] to jump to the split in the direction specified
nnoremap <leader>h <c-w>h
nnoremap <c-w>h <nop>
nnoremap <leader>j <c-w>j
nnoremap <c-w>j <nop>
nnoremap <leader>k <c-w>k
nnoremap <c-w>k <nop>
nnoremap <leader>l <c-w>l
nnoremap <c-w>l <nop>

" Sets <leader>ev to edit your VIMRC file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" Sets <leader>sv to source your VIMRC file
nnoremap <leader>sv :source $MYVIMRC<cr>

" Sets <esc> to exit terminal mode in neovim
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
endif

" Set quick motions for altering interiors of parenths, brackets, and curly braces
onoremap ( i(
onoremap [ i[
onoremap { i{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""ABBREVIATIONS""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Correct some common misspellings
iabbrev adn and
iabbrev coutn count
iabbrev improt import
iabbrev calss class

" Add some quick inserts
iabbrev git_me https://github.com/somexpert
iabbrev git_mark https://github.com/vphill
iabbrev git_lauren https://github.com/ldko
iabbrev git_damon https://github.com/damonkelley
iabbrev git_jasone https://github.com/jason-ellis
iabbrev git_jasont https://github.com/jthomale
iabbrev git_will https://github.com/whicks1
iabbrev git_joey https://github.com/yeahdef
iabbrev git_kurt https://github.com/kurtnordstrom

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""TESTING"""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
