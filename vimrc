"Type :so % to reload vimrc

" Pathogen
execute pathogen#infect()

"This setting should come first because it affects other settings below
set nocompatible
" Leader is spacebar
let mapleader = " "

syntax on
set ignorecase
set rnu
filetype indent on
set shiftwidth=4
set tabstop=4
set expandtab
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set background=light
color zellner
set autoread " Reload files changed outside vim
" set cursorline
set laststatus=2

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
" nnoremap <CR> o<Esc>
" Fix issues with Enter in Command Window
" autocmd CmdwinEnter * nnoremap <CR> <CR>
" autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Navigate properly when lines are wrapped
nnoremap j gj
nnoremap k gk

" Use tab to jump between blocks
nnoremap <tab> %
vnoremap <tab> %

function! UpdateCscope()
    cs kill 0
    !if [ -x scripts/update-cscope ]; then scripts/update-cscope; else update-cscope; fi
    cs add cscope.out
endfunction

function! ReloadCscope()
    cs kill 0
    cs add cscope.out
endfunction

function! AddCpp(base_name)
    execute '!./scripts/add-cpp ' . a:base_name
    " execute 'tabe src/' . a:base_name . '.cpp'
endfunction

highlight lCursor guifg=NONE guibg=Cyan
highlight Visual ctermfg=Black ctermbg=White

command! EnableSpell execute "setlocal spell spelllang=ru_ru,en_us"
command! DisableSpell execute "setlocal spell!"
command! Help execute "echo 'commands: EnableSpell, DisableSpell, HL, UCS, RCS, Cp, Help\nkeys: Leader-r space, Leader-e new line'"
command! HL execute "call g:ClangUpdateQuickFix()"
command! D execute "tab sp"
command! DA execute "tab sp | A"
command! UCS execute "call UpdateCscope()"
command! RCS execute "call ReloadCscope()"
command! -nargs=1 Addcpp call AddCpp(<q-args>)
command! -nargs=1 Removecpp execute "!./scripts/remove-cpp " string(<q-args>)

nnoremap <Leader><F4> :D<CR>
noremap <Up> <C-U>
noremap <Down> <C-D>
" nnoremap <kMinus> <C-U>
" nnoremap <kPlus> <C-D>
inoremap jk <ESC>

" code navigation
nnoremap <F12> :call g:ClangGotoDeclaration()<CR>
nnoremap <F7> :call g:ClangUpdateQuickFix()<CR>
nnoremap <Leader>w :call g:ClangGotoDeclarationPreview()<CR>
nnoremap <C-_> <C-T>
nnoremap <F4> :A<CR>
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
set completeopt=menu
inoremap <Tab> <C-R>=pumvisible() ? "\<lt>C-N>\<lt>C-y>" : "\<lt>Tab>"<CR>
inoremap <C-@> <C-R>="\<lt>C-X>\<lt>C-U>\<lt>C-P>"<CR>

if has("unix")
    " let g:clang_library_path='/usr/lib/llvm-3.6/lib/'
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
" nnoremap <F4> :call ToggleRelativeOn()<cr>

" TComment uses leader, which makes space delay in insert mode

let g:tcommentMapLeader2 = '\' "{{{2

" Map ctrl-n to NERD Tree
map <F9> :NERDTreeToggle<CR><F3>

" ctrl-p section
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_follow_symlinks = '1'
let g:ctrlp_custom_ignore = {
            \ 'file': '\v\.(exe|so|dll|obj|o|d|dep)$'
            \ }
" Source files in vimgrep
let @s = "./**/*.c ./**/*.h ./**/*.hpp ./**/*.cpp"

" Insert space
nnoremap <leader>r i<space><esc>

" Split line
nnoremap <leader>e i<CR><esc>

" Copy file name to the buffer
command! Cp execute "let @+=expand('%:t') . ':' . line('.')"

" Line navigation
nnoremap <leader>d _
nnoremap <leader>f $

" Empty line
nnoremap <leader>j o<ESC>
nnoremap <leader>k O<ESC>

" Select a block. It selects a function body
nnoremap <c-b> vaB

if has('gui_running')
    colo darkblue
endif
inoremap <F2> <ESC>o{<CR>}<ESC>ko
" inoremap <F3> }

" Quick Cscope
let g:quickr_cscope_keymaps = 0
let g:quickr_cscope_autoload_db = 0
let g:quickr_cscope_use_qf_g = 1
nmap <leader><F12> <plug>(quickr_cscope_symbols)
nmap <leader>t<F12> <plug>(quickr_cscope_global)

" Mouse scrolling
set mouse=a
noremap <ScrollWheelUp> <C-U>
noremap <ScrollWheelDown> <C-D>

" vimux
nnoremap <leader>vp :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>
