set nocompatible              " be iMproved, required
filetype off                  " required
syntax enable
" set the runtime path to include Vundle and initialize
let mapleader = ','
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'HealsCodes/vim-gas'
Plugin 'LunarWatcher/auto-pairs'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'puremourning/vimspector'
call vundle#end()            " required
filetype plugin on    " required

colorscheme slate
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
command CC !cc -g -Wall -Wextra -Werror *.c -o output && ./output
command C !norminette *.c
nnoremap <C-a> :vs +Explore<CR>
nnoremap <C-t> :tabnew<cr>
nnoremap <S-h> :tabprev<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-<> 10<C-w><<>
nnoremap <C->> 10<C-w><>>
inoremap jk <esc>
vnoremap jk <esc>
cnoremap jk <esc>
inoremap <M-tab> <C-n>
inoremap { {}<esc>ha
inoremap ( ()<Esc>ha
inoremap [ []<Esc>ha
inoremap " ""<Esc>ha
inoremap ' ''<Esc>ha
inoremap ` ``<Esc>ha

"vimspector
nnoremap <F2> :VimspectorDisassemble<cr>
nnoremap <F3> :VimspectorReset<cr>:set mouse=<cr>
nnoremap <F4> <Plug>VimspectorRestart
nnoremap <F5> :set mouse=a<cr><Plug>VimspectorContinue<cr>
nnoremap <F6> <Plug>VimspectorPause
nnoremap <F8> <Plug>VimspectorBreakpoint
nnoremap <F10> <Plug>VimspectorStepOver
nnoremap <F11> <Plug>VimspectorStepInto
nnoremap <F12> <Plug>VimspectorStepOut

function! CheckBackSpace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


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
