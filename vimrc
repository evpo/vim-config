"Type :so % to reload vimrc

"This setting should come first because it affects other settings below
set nocompatible
" Leader is spacebar
let mapleader = " "

syntax on
set ignorecase
set number
filetype indent on
set shiftwidth=4
set tabstop=4
set expandtab
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set background=dark
set autoread " Reload files changed outside vim

if has("unix")
    " Trigger autoread when changing buffers
    au FocusGained,BufEnter * :silent! !
    " set cursorline
endif

set wildmenu " select files when pressing Tab
set wildmode=list:longest,full

set incsearch " fast incremental search. Only on fast terminals

set showmatch " highlight matching braket

" Display extra whitespace
if has("unix")
    set list listchars=tab:»·,trail:·,nbsp:·
endif
" Make it obvious where 100 characters is
" set textwidth=100
" set wrapmargin=0
set splitright

" Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

"Use enter to create new lines
nnoremap <CR> o<Esc>
" Fix issues with Enter in Command Window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use tab to jump between blocks
nnoremap <tab> %
vnoremap <tab> %

highlight lCursor guifg=NONE guibg=Cyan
command! EnableSpell execute "setlocal spell spelllang=ru_ru,en_us"
command! DisableSpell execute "setlocal spell!"
command! Help execute "echo 'commands: EnableSpell, DisableSpell, HL, Help'"
command! HL execute "call g:ClangUpdateQuickFix()"
command! D execute "tab sp"
command! DA execute "tab sp | A"
noremap <Up> <C-U>
noremap <Down> <C-D>
" nnoremap <kMinus> <C-U>
" nnoremap <kPlus> <C-D>
inoremap jj <ESC>

" code navigation
nnoremap <F12> <C-]>
nnoremap <Leader><F12> :cs f s <cword><CR>
nnoremap <Leader>w :call g:ClangGotoDeclarationPreview()<CR>
nnoremap <C-_> <C-T>
map <F4> :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>
"Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>
"In putty you need to disable Ctrl S. Add these lines to your .bashrc:
"stty ixany
"stty ixoff -ixon
nnoremap <silent> <c-s> :w<CR>
let g:clang_use_library=1
let g:clang_complete_copen=1

if has("unix")
    let g:clang_library_path='/usr/lib/llvm-3.6/lib/'
else
    let g:clang_library_path='C:/Program Files (x86)/LLVM/bin'
endif

"let g:clang_auto_user_options='compile_commands.json'
"let g:clang_debug=1
set timeoutlen=1000 ttimeoutlen=0

"System clipboard support
nnoremap <leader>v "+
vnoremap <leader>v "+

"Simplified access to 0 register
nnoremap <leader>p "0
vnoremap <leader>p "0

" resize panes
" nnoremap <silent> <Right> :vertical resize +5<cr>
" nnoremap <silent> <Left> :vertical resize -5<cr>
" nnoremap <silent> <Down> :resize +5<cr>
" nnoremap <silent> <Up> :resize -5<cr>

" quickly close window
nnoremap <leader>x :x<cr>
nnoremap <leader>X :q!<cr>
nnoremap <leader>q :q<cr>

" switch between last two files
" nnoremap <leader><leader> <c-^>

set directory=~/tmp

"Navigate vim windows with Ctrl+hjkl
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

"tmux-navigator settings

let g:tmux_navigator_save_on_switch = 1

" relative numbers
function! ToggleNumbersOn()
    set nu!
    set rnu
endfunction

function! ToggleRelativeOn()
    set rnu!
    set nu
endfunction

nnoremap <F3> :call ToggleNumbersOn()<cr>
nnoremap <F4> :call ToggleRelativeOn()<cr>

" TComment uses leader, which makes space delay in insert mode

let g:tcommentMapLeader2 = '\' "{{{2

" Map ctrl-n to NERD Tree
map <F9> :NERDTreeToggle<CR>

" ctrl-p section
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_custom_ignore = {
            \ 'file': '\v\.(exe|so|dll|obj|o)$'
            \ }
" Source files in vimgrep
let @s = "./**/*.c ./**/*.h ./**/*.hpp ./**/*.cpp"

" Insert space
nnoremap <leader>s i<space><esc>

" Paste the same value multiple
vnoremap p "0p

" Copy file name to the buffer
command! GetFile execute "let @+=expand('%:t') . ':' . line('.')"

" Line navigation
nnoremap <leader>h _
nnoremap <leader>l $

" Empty line
nnoremap <leader>j o<ESC>
nnoremap <leader>k O<ESC>

" Select a block. It selects a function body
nnoremap <c-b> vaB
