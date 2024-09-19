set nocompatible              " be iMproved, required
set clipboard+=unnamedplus

filetype off                  " required
" set the runtime path to include Vundle and initialize
let mapleader = ','
let g:nvim_tree_show_icons = 1

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'rust-lang/rust.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'VundleVim/Vundle.vim'
call vundle#end()            " required
filetype plugin on    " required
set ttimeoutlen=100

colorscheme retrobox
let g:onedark_config = {
    \ 'style': 'warmer',
\}
set cursorline
set cursorcolumn
set mouse=
set bs=2
set tabstop=4
set	softtabstop=4
set shiftwidth=4
set number
set smarttab
set relativenumber
set timeoutlen=200
set cindent
set autoindent
set	smartindent
set	completeopt=menuone,longest

"shortcuts
command CC !cc -g -Wall -Wextra *.c -o output && ./output
command C !norminette *.c
nnoremap <S-t> :vertical terminal <CR>
nnoremap <C-w> :NvimTreeToggle<cr>
nnoremap <C-t> :tabnew 
nnoremap <S-h> :tabprev<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-<> 10<C-w><<>
nnoremap <C->> 10<C-w><>>
nnoremap <C-left> 5<c-w><
nnoremap <C-right> 5<c-w>>
nnoremap <C-up> 5<c-w>+
nnoremap <C-down> 5<c-w>-
inoremap jk <esc>
cnoremap jk <esc>
inoremap <M-tab> <C-n>
inoremap { {}<esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha
tnoremap <Esc> <C-\><C-n>

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

augroup cVariables
    autocmd!
    autocmd FileType c syntax match cVariable /\v\<[a-zA-Z_]\w*\>/ contained
    autocmd FileType c highlight cVariable guifg=#90ee90
augroup END

function! s:set_c_variable_highlight()
    highlight cVariable ctermfg=blue
endfunction

autocmd FileType c call s:set_c_variable_highlight()


set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor
