set nocompatible              " be iMproved, required
set clipboard+=unnamedplus

let mapleader=" "

set guicursor=a:blinkoff0
filetype off                  " required
" set the runtime path to include Vundle and initialize
autocmd FileType netrw vertical resize 30
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" Plugin 'rust-lang/rust.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'VundleVim/Vundle.vim'
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-surround'
Plugin 'LunarWatcher/auto-pairs'
Plugin 'Tetralux/odin.vim'
Plugin 'neoclide/coc.nvim'
call vundle#end()            " required
filetype plugin on    " required

if executable('ols')
  autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'ols',
        \ 'cmd': ['ols'],
        \ 'root_uri': lsp#utils#path_to_uri(getcwd()),
        \ 'allowlist': ['odin'],
        \ })
endif

" Adjust CursorLine to have a brighter background for easy identification
highlight CursorLine cterm=none ctermbg=235 guibg=#5a5a5a

" Adjust CursorColumn with a slightly darker background than CursorLine
highlight CursorColumn cterm=none ctermbg=235 guibg=#5e5e5e
set ttimeoutlen=200
set cursorline
set cursorlineopt=screenline,number
set cursorcolumn
set mouse=a
set bs=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set number
set smarttab
set relativenumber
set timeoutlen=200
set autoindent
set smartindent
set completeopt=menuone,longest
set wildmode=longest,full
set wildmenu
set list
set wildoptions=pum
"
"shortcuts
nnoremap <S-t> :vertical terminal <CR>
nnoremap <silent> <C-s> :call ToggleNetrw()<cr>
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
nnoremap <silent> <C-b> :let @/="" <Bar>noh<CR>
nmap <leader>rn <Plug>(coc-rename)

function! ToggleNetrw()
	if &filetype ==# 'netrw'
		quit
	else
		Vexplore
	endif
endfunction

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use Tab and Shift-Tab to navigate between placeholders in a snippet
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : coc#pum#visible() ? "\<C-n>" : coc#snippet#next()
inoremap <silent><expr> <S-Tab> coc#pum#visible() ? "\<C-p>" : coc#snippet#prev()


"COC
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>r <Plug>(coc-rename)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction
set encoding=utf-8
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'
