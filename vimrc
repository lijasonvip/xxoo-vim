"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       libin
"       libin@sangfor.com.cn
"
" Version:
"       2.0 - 18/10/16 17:25:36
"
" Blog_post:
"       http://amix.dk/blog/post/19691#The-ultimate-Vim-configuration-on-Github
"
" Awesome_version:
"       Get this config, nice color schemes and lots of plugins!
"
"       Install the awesome version from:
"
"           https://github.com/amix/vimrc
"
" Syntax_highlighted:
"       http://amix.dk/vim/vimrc.html
"
" Raw_version:
"       http://amix.dk/vim/vimrc.txt
"
" Sections:
"    -> General
"    -> Plugin Manager Vundle
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking (abandoned now.)
"    -> Misc
"    -> Helper functions
"    -> Cscope
"    -> QuickFix
"    -> Plugins Configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
set clipboard=unnamedplus

" set tags file name...
" set tags=./.tags;,.tags " 前半部分 “./.tags; ”代表在文件的所在目录下（不是 “:pwd”返回的 Vim 当前目录）查找名字为 “.tags”的符号文件，后面一个分号代表查找不到的话向上递归到父目录，直到找到 .tags 文件或者递归到了根目录还没找到
if filereadable("./tags")
    set tags=./tags,tags
endif
" When on, Vim will change the current working directory whenever you
" open a file, switch buffers, delete a buffer or open/close a window.
" It will change to the directory containing the file which was opened
" or selected.
" Note: When this option is on some plugins may not work.
" set autochdir

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
" option 1: ctrl-s, you should turn your termianl's flowcontrol(ctrl-q ctrl-s) off
" nnoremap <c-s> :w!<cr>
" inoremap <c-s> <ESC>:w!<cr>a
" option 2: a little bit slower than option 1, but it's acceptable, I've used this for a long time
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" C-d is 'delete indent before cursor(see help)'
" replace it with 'delete word after cursor in insert mode', same as zsh shell
" imap <C-d> <C-[>ldei

" the magic method from stack overflow
" http://stackoverflow.com/questions/6778961/alt-key-shortcuts-not-working-on-gnome-terminal-with-vim
" enable the terminal alt
if has("UNIX")
    let c='a'
    while c <= 'z'
      exec "set <A-".c.">=\e".c
      exec "imap \e".c." <A-".c.">"
      let c = nr2char(1+char2nr(c))
    endw

    " man 帮助
    runtime ftplugin/man.vim
    cmap man Man
    nmap K :Man <cword><CR>
endif

" ESC 延迟，不好用
set timeout ttimeoutlen=0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Manager Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" c/cxx
" 需要配合 ccls 使用
Plugin 'prabirshrestha/asyncomplete.vim'     " go c/c++
Plugin 'prabirshrestha/asyncomplete-lsp.vim' " go c/c++
Plugin 'prabirshrestha/vim-lsp'              " go c/c++
Plugin 'prabirshrestha/async.vim'            " go c/c++
Plugin 'octol/vim-cpp-enhanced-highlight' " cxx 额外高亮
Plugin 'vim-scripts/a.vim' " h.cpp 切换

" for golang
Plugin 'fatih/vim-go' " go 相关工具

" 通用
Plugin 'Shougo/echodoc.vim' " 补全时显示参数，YCM 再也不蛋疼了, 蛋疼的是该插件默认不启用
Plugin 'junegunn/fzf.vim'   " fuzzy finder 神器, 虽然 fuzzy 算法不是很好，但集成 vim 与 zsh，将就用
Plugin 'jiangmiao/auto-pairs' " 自动括号匹配
Plugin 'terryma/vim-multiple-cursors'   " 多cursor, see help vim-multiple-cursors
Plugin 'tpope/vim-commentary'       " gc 注释
Plugin 'easymotion/vim-easymotion' " 快速移动
Plugin 'bronson/vim-trailing-whitespace' " 显示空格
Plugin 'vim-airline/vim-airline'    " 强力标题栏, 配置于Segment Status Line...
Plugin 'vim-airline/vim-airline-themes'
Plugin 'majutsushi/tagbar'        " 符号展示
Plugin 'ryanoasis/vim-devicons'   " 字体加入图标, Set VimDevIcons to load after these plugins!  NERDTree | vim-airline | CtrlP | powerline | unite | lightline.vim | vim-startify | vimfiler | flagship



" Plugin 'ludovicchabant/vim-gutentags' " tag 管理，一般代码用不着，看 linux 内核代码比较有用

" theme
Plugin 'fatih/molokai'
"
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use system clipboard as primary register
set clipboard=unnamedplus

" Set 4 lines to the cursor - when moving vertically using j/k
set so=4
" set 80 colums tips
set colorcolumn=120

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the WiLd menu
set wildmenu

" set cursor line
set cursorline
set cursorcolumn

set nu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
elseif has("")
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" In many terminal emulators the mouse works just fine, thus enable it.
" if has('mouse')
"   set mouse=a
" endif

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
" set noerrorbells
" set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1


" see help backspace
set backspace=indent,eol,start
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" really important for all colortheme
" set background=dark
"
" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
set t_Co=256

if has("gui_running")
    " Set extra options when running in GUI mode
    set t_Co=256
    set guioptions-=T
    set guioptions-=e
    set guioptions-=m
    set guitablabel=%M\ %t

    if has("win16") || has("win32")
        set guifont=Microsoft\ YaHei\ Mono:h14:cANSI
    elseif has("mac") || has("macunix")
        set guifont=Monaco\ For\ Powerline\ Nerd\ Font\ Complete:h12
        " set guifont=Hurmit\ Medium\ Nerd\ Font\ Complete\ Mono:h13
    else
        " set guifont=Monaco\ For\ Powerline\ 13
        set guifont=DroidSansMono\ Nerd\ Font\ 14
    endif
endif



try
    " colorscheme iceberg
    colorscheme molokai
    let g:rehash256 = 1
    let g:molokai_original = 1
catch
    colorscheme ron
endtry



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Open Current Windows in new tab, super useful
" ctrl-w + T

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" no line break, insert \r when you need it...
set nolinebreak
" set textwidth=500

set ai " Auto indent
set si " Smart indent
set nowrap " Wrap lines, show a long line input two lines(with only one line num), press F9 to change the behaviour

" show tab, >> can be input Enter the right-angle-quote by pressing Ctrl-k then >>
" see ctrl+k and :dig
set list listchars=tab:~▪,trail:✗
""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
" map j gj
" map k gk

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <c-space> ?

" Disable highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :noh<cr>

" Buffers
" Close the current buffer
" nnoremap <leader>bd :Bclose<cr>:tabclose<cr>gT
" Useful mappings for managing tabs
nnoremap ]b  :bnext<cr>
nnoremap [b  :bprevious<cr>
"
" Useful mappings for managing tabs
let g:lasttab = 1
nnoremap ]t  :tabnext<cr>
nnoremap [t  :tabprevious<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
" Let 'tl' toggle between this and the last accessed tab
au TabLeave * let g:lasttab = tabpagenr()
" nnoremap <leader>tt  :exe "tabn ".g:lasttab<CR>
" nnoremap <leader>to  :tabonly<cr>
" nnoremap <leader>tc  :tabclose<cr>
" nnoremap <leader>tm  :tabmove
" nnoremap <leader>tf  :tabfirst<cr>
" nnoremap <leader>tl  :tablast<cr>
" nnoremap <leader>t%  :tabedit %<cr>
" nnoremap <leader>te  :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
" map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
" Remember info about open buffers on close
set viminfo^=%

" go shouldn't use following:
" 1. show tab
" 2. expand tab
autocmd FileType go set nolist
autocmd FileType go set noexpandtab
""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
nmap 0 ^

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>


" When you press <leader>, you can search and replace the selected text
" vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" move some content to quickfix chapter in this file...see it now!


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
" noremap <Leader><Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
" map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ag \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cscope & ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This tests to see if vim was configured with the '--enable-cscope' option
" when it was compiled.  If it wasn't, time to recompile vim...
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out
    " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.
    "

    noremap <leader>r :cs find s <C-R>=expand("<cword>")<CR><CR>
    " autocmd FileType go noremap <leader>r :GoReferrers<CR>
    noremap <leader>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    " autocmd FileType go noremap <leader>g :GoDef<CR>
    noremap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " autocmd FileType go noremap <leader>c :GoCaller<CR>
    noremap <leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    noremap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    noremap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    noremap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    " noremap <leader><m-d> :cs find d <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>

    " nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    " nmap <M-r> :scs find s <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    " nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    " nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    " nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>


    " Hitting CTRL-space *twice* before the search type does a vertical
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    " nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    " nmap <leader><leader>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    " nmap <leader><leader>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    "
    " nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => QuickFix
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"
" In the quickfix window, you can use:
" e    to open file and close the quickfix window
" o    to open (same as enter)
" go   to preview file (open but maintain focus on ag.vim results)
" t    to open in new tab
" T    to open in new tab silently
" h    to open in horizontal split
" H    to open in horizontal split silently
" v    to open in vertical split
" gv   to open in vertical split silently
" q    to close the quickfix window
"

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To close quick quickfix
"   <leader>cq
" To go to the next search result do:
"   <leader>n
"

 " 弹出quickfix
nmap <leader>qo :botright cope<cr>
nmap <leader>qc :cclose<cr>

nmap <leader>qn :cn<cr>
nmap <leader>qp :cp<cr>

" copy current file into a new tab...
nmap <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => PluginSettings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" airline theme, you definately need this...
let g:airline_theme = 'fairyfloss'


" settings: vim-lsp
if executable('ccls')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'ccls',
				\ 'cmd': {server_info->['ccls']},
				\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
				\ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }, 'detailedLabel': 'true', 'highlight': { 'lsRanges' : v:true }, },
				\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
				\ })
endif

"" Key bindings for vim-lsp.
nn <silent> <m-g> :LspDefinition<cr>
autocmd FileType go nn <silent> <m-g> :GoDef<cr>

nn <silent> <m-r> :LspReferences<cr>
autocmd FileType go nn <silent> <m-r> :GoReferrers<cr>

nn <silent> <m-s> :LspWorkspaceSymbol<cr>

nn <silent> <m-l> :LspDocumentSymbol<cr>
autocmd FileType go nn <silent> <m-l> :GoDeclsDir<cr>

nn <silent> <f9> ::LspDocumentDiagnostics<cr>
" nn <f2> :LspRename<cr>

let g:asyncomplete_smart_completion = 1
let g:asyncomplete_auto_popup = 1

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

" settings: easymotion...
let g:EasyMotion_smartcase = 1
" map f <Plug>(easymotion-prefix)
" TODO: add inline easymotion action
nmap <m-f> <Plug>(easymotion-s)
nmap <m-w> <Plug>(easymotion-w)
nmap <m-b> <Plug>(easymotion-bd-w)
nmap <m-e> <Plug>(easymotion-bd-e)
nmap <m-j> <Plug>(easymotion-j)
nmap <m-k> <Plug>(easymotion-k)
nmap <m-n> <Plug>(easymotion-bd-n)


" settings echodoc
" default is disable
let g:echodoc#enable_at_startup = 1

" settings a.vim
" alt-o :A 头文件切换
" nnoremap <m-o> :A<cr>

" settings fzf
" ag from fzf
nnoremap <leader>ag :Ag <C-R>=expand("<cword>")<CR>
" vim ignore file types
let $FZF_DEFAULT_COMMAND = 'find $(pwd) -name "*.h" -o -name "*.c" -o -name "*.cpp" -o -name "*.cc" -o -name "*.hpp" -o -name "*.cxx" -o -name "*.go" -o -name "*.sh" -o -name "*.jce" -o -name "*.proto"'
let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
" user c-a c-q to select result in quickfix window
function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
endfunction
let g:fzf_action = {
            \ 'ctrl-q': function('s:build_quickfix_list'),
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" settings others
noremap <c-p> :Files<CR>
" noremap <c-p> :Marks<CR>s
noremap \t :Tags<CR>
noremap \] :BTags<CR>
noremap \m :Marks<CR>
noremap \\ :Buffers<CR>
noremap \w :Windows<CR>

" 在quickfix窗口按 p 打开预览窗口（配合 grepper 插件很实用）
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

" settings vim-go
" 用quickfix作为错误显示列表
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
" trigger metalint when you save file...
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
" life of meta line running...
let g:go_metalinter_deadline = "2s"
"
"
"
"

" 查哪个插件启动慢的命令
" vim --startuptime /tmp/vim.log a.c



