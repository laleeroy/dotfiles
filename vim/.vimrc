" ------------------------------
" BASIC SETTINGS
" ------------------------------
set number
set paste
set relativenumber
set cursorline
set clipboard=unnamedplus
set noshowmode
set splitbelow
set splitright

nnoremap ; :
vnoremap ; :
nnoremap / /\c
vnoremap / /\c

let mapleader = " "

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

autocmd FileType c,cpp setlocal formatprg=clang-format
" ------------------------------
" PLUGINS
" ------------------------------
call plug#begin('~/.vim/plugged')

Plug 'catppuccin/vim', { 'as': 'catppuccin' }

Plug 'preservim/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

call plug#end()

set background=dark
colorscheme catppuccin_mocha

" ------------------------------
" NERDTREE
" ------------------------------
nnoremap <leader>e :NERDTreeToggle<CR>
let g:NERDTreeShowHidden = 1

" ------------------------------
" ADDITIONAL KEY MAPPINGS
" ------------------------------
" Clear search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :x<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
