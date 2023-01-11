"Type :so % to reload vimrc

" Pathogen
execute pathogen#infect()

"This setting should come first because it affects other settings below
set nocompatible
filetype off

" --------------
" Begin Vundle
" set the runtime path to include Vundle and initialize
" Run the command below to install
" python3 install.py --clang-completer --cs-completer --java-completer
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" All of your Plugins must be added before the following line
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'gregsexton/gitv'
call vundle#end()            " required
filetype plugin indent on    " required
" End Vundle
" --------------

" Leader is spacebar
let mapleader = " "
syntax on
set ignorecase
set rnu
set nu
filetype indent on
set shiftwidth=4
set tabstop=4
set expandtab
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" color industry
" color vc
color default
set background=dark
set autoread " Reload files changed outside vim
" set cursorline
set laststatus=2
set encoding=utf-8

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
    set list listchars=tab:»·,trail:·
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
    !if [ -x scripts/update-cscope ]; then scripts/update-cscope; else cscope -Rb ; fi
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

command! EnableSpell execute "setlocal spell spelllang=ru_ru,en_gb"
command! DisableSpell execute "setlocal spell!"
command! Help execute "echo 'commands: EnableSpell, DisableSpell, HL, UCS, RCS, Cp, Help\nkeys: Leader-r space, Leader-e new line'"
command! HL execute "call g:ClangUpdateQuickFix()"
command! D execute "tab sp"
command! DA execute "tab sp | A"
command! UCS execute "call UpdateCscope()"
command! RCS execute "call ReloadCscope()"
command! -nargs=1 Addcpp call AddCpp(<q-args>)
command! -nargs=1 Removecpp execute "!./scripts/remove-cpp " string(<q-args>)

" tabs
nnoremap <Leader><F4> :D<CR>

function! Mtab(vert)
    if tabpagenr() == tabpagenr("$")
        return 0
    endif
    +tabnext
    let s:killed_tab = tabpagenr()
    let s:buf_list = tabpagebuflist()
    -tabnext
    for item in s:buf_list
        if a:vert
            vsp
        else
            sp
        endif
        execute "buf " . item
    endfor
    execute "tabclose " . s:killed_tab
endfunction

command! Mtabsp call Mtab(0)
command! Mtabvsp call Mtab(1)

" end tabs

noremap <Up> <C-U>
noremap <Down> <C-D>
inoremap jk <ESC>

" code navigation
" nnoremap <F12> :call g:ClangGotoDeclaration()<CR>
nnoremap <F12> :YcmCompleter GoTo<CR>
" nnoremap <F7> :call g:ClangUpdateQuickFix()<CR>
" nnoremap <F7> ::YcmForceCompileAndDiagnostics<CR>
nnoremap <C-_> <C-T>
nnoremap <F4> :A<CR>
"Tab navigation
nnoremap th  :tabfirst<CR>
nnoremap tk  :tabnext<CR>
nnoremap tj  :tabprev<CR>
nnoremap tl  :tablast<CR>

"Resize windows

nnoremap <Leader>wh :vert resize -20<CR>
nnoremap <Leader>wl :vert resize +20<CR>
nnoremap <Leader>wk :resize -10<CR>
nnoremap <Leader>wj :resize +10<CR>
"
"In putty you need to disable Ctrl S. Add these lines to your .bashrc:
"stty ixany
"stty ixoff -ixon
nnoremap <silent> <c-s> :w<CR>
"let g:clang_use_library=1
" TODO: activate clang again
"let g:clang_complete_copen=1
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
set clipboard=unnamedplus
" nnoremap <leader>v "+
" vnoremap <leader>v "+

"Simplified access to 0 register
nnoremap <leader>o "0
vnoremap <leader>o "0

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

" TComment uses leader, which makes space delay in insert mode

let g:tcommentMapLeader2 = '\' "{{{2

" NERDTree
" Map ctrl-n to NERD Tree
map <F9> :NERDTreeToggle<CR>:set rnu<CR>
nnoremap <leader><F9> :NERDTreeFind<CR>:set rnu<CR>
" Ignore certain files
let NERDTreeIgnore=['\.o$[[file]]','\.d$[[file]]']

" ctrl-p section
let g:ctrlp_working_path_mode = '0'
let g:ctrlp_max_files = 40000
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
command! Cpfn execute "let @+=expand('%') . ':' . line('.')"
command! Cpabs execute "let @+=expand('%:p') . ':' . line('.')"

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
" Use below for other languages such as Java
" nmap <leader><F12> :YcmCompleter GoToReferences<CR>
nmap <leader>t<F12> <plug>(quickr_cscope_global)
nmap <leader>tp :CtrlPTag<CR>
nmap <leader>tf :YcmCompleter FixIt<CR>

" Mouse scrolling
set mouse=a
noremap <ScrollWheelUp> <C-U>
noremap <ScrollWheelDown> <C-D>

" vimux
nnoremap <leader>vr :VimuxPromptCommand<CR>
nnoremap <leader>vl :VimuxRunLastCommand<CR>

" Format xml
com! Xmllint :%!xmllint --format -

" Smart paste
nnoremap <leader>p :call SmartPaste()<CR>
nnoremap <leader>y yiW

" Tagbar
nnoremap <F3> :TagbarToggle f<CR>:set rnu<CR>
" YCM
let g:ycm_auto_hover=''

" vimdiff
if &diff
    syntax off
    colorscheme industry
    nnoremap <leader>q :qa<cr>
endif

" svnlog
function! SvnlogEx(svn_root, exclude_bbot)
    execute "1,$d"
    let exclude_bbot_option=""
    if (a:exclude_bbot)
        let exclude_bbot_option=" --exclude-bbot "
    endif
    let output_lines = systemlist("svnlog log --svn-root " . a:svn_root . exclude_bbot_option . " --days 5")
    call append(0, output_lines)
endfunction

function! Svnlog()
    let svn_root = $SVNROOT
    call SvnlogEx(svn_root, 1)
endfunction

function! SvnlogDiff(rev)
    call feedkeys(':!tmux split-pane "svnlog diff -r ' . a:rev . '"')
endfunction

function! SvnlogMapKeys()
    nnoremap <F6> :execute Svnlog()<CR>
    call feedkeys("/^[0-9]\<CR>")
    "nnoremap <F7> yiW::execute SvnlogDiff(<C-R>")<CR>
    nnoremap <F7> yiW:!tmux split-pane "svnlog diff -r <C-R>""<CR><CR>
endfunction

command! SvnlogMapKeys execute SvnlogMapKeys()
