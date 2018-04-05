"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" User configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" turn off nice effect on status bar title
let performance_mode=0

set nocompatible
"set autochdir

"Map space to / and c-space to ?
map <space> /

"Smart way to move btw. window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" window resize Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"resize horzontal split window
nmap <S-Left> <C-W><<C-W><
nmap <S-Right> <C-W>><C-W>>

"resize vertical split window
nmap <S-Down> <C-W>-<C-W>-
nmap <S-Up> <C-W>+<C-W>+

"Set mapleader
let mapleader = ","
let g:mapleader = ","
"set verbose=9
"
"fast load vimrc
nnoremap <leader>ev :vsplit $MYVIMRC
nnoremap <leader>sv :source $MYVIMRC

onoremap k i(

" esc
inoremap jk <esc>
"inoremap <esc> <nop>

if &term =~ '^\(xterm\|screen\)$'
    set t_Co=256
endif

function! MySys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

"Set shell to be bash
if MySys() == "unix" || MySys() == "mac"
    set shell=bash
else
    "I have to run win32 python without cygwin
    "set shell=E:cygwininsh
endif


"Sets how many lines of history VIM har to remember
set history=400

"Enable filetype plugin
filetype on
if has("eval") && v:version>=600
    filetype plugin on
    filetype indent on
endif

"Set to auto read when a file is changed from the outside
if exists("&autoread")
    set autoread
endif

"Have the mouse enabled all the time:
if exists("&mouse")
    set mouse=a "Cause the mouse cannot copy on right click
endif


"Fast saving
nmap <leader>x :xa!<cr>
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
if MySys()=="unix"
    if v:version<600
        if filereadable(expand("$VIM/syntax/syntax.vim"))
            syntax on
        endif
    else
        syntax on
    endif
else
    syntax on
endif


"internationalization
if has("multi_byte")
    "set bomb
    set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1
    " CJK environment detection and corresponding setting
    if v:lang =~ "^zh_CN"
        " Use cp936 to support GBK, euc-cn == gb2312
        set encoding=cp936
        set termencoding=cp936
        set fileencoding=cp936
    elseif v:lang =~ "^zh_TW"
        " cp950, big5 or euc-tw
        " Are they equal to each other?
        set encoding=big5
        set termencoding=big5
        set fileencoding=big5
    elseif v:lang =~ "^ko"
        " Copied from someone's dotfile, untested
        set encoding=euc-kr
        set termencoding=euc-kr
        set fileencoding=euc-kr
    elseif v:lang =~ "^ja_JP"
        " Copied from someone's dotfile, untested
        set encoding=euc-jp
        set termencoding=euc-jp
        set fileencoding=euc-jp
    endif
    " Detect UTF-8 locale, and replace CJK setting if needed
    if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
    endif
endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
    set ambiwidth=double
endif

"let g:molokai_original = 1
let g:rehash256 = 1
if has("gui_running")
    set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    if MySys()=="win32"
        "start gvim maximized
        if has("autocmd")
            au GUIEnter * simalt ~x
        endif
    endif
    "let psc_style='cool'
    if v:version > 601
        colorscheme molokai
        "colorscheme dracula
    endif
else
    if v:version > 601
        colorscheme molokai
        "colorscheme dracula
    endif
endif

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
nnoremap <leader>1 :set syntax=cheetah<cr>
nnoremap <leader>2 :set syntax=xhtml<cr>
nnoremap <leader>3 :set syntax=python<cr>
nnoremap <leader>4 :set ft=javascript<cr>
nnoremap <leader>$ :syntax sync fromstart<cr>

"Highlight current
if has("gui_running")
    if exists("&cursorline")
        set cursorline
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Always show current position
set ruler

"Show line number
set nu
set relativenumber

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch

"Set magic on
set magic

"No sound on errors.
set noerrorbells
set novisualbell
set t_vb=

"show matching bracet
set showmatch

"Highlight search thing
set hlsearch

set pastetoggle=<F12>

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
if performance_mode
else
    set laststatus=2
    set statusline=
    set statusline+=%2*%-3.3n%0*\   " buffer number
    set statusline+=%f\ " file name
    set statusline+=%h%1*%m%r%w%0*  " flags
    set statusline+=[
    if v:version >= 600
        set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
        set statusline+=%{&encoding}, " encoding
    endif
    set statusline+=%{&fileformat}] " file format
    if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
        set statusline+=\ %{VimBuddy()} " vim buddy
    endif
    set statusline+=%= " right align
    set statusline+=%2*0x%-8B\ " current char
    set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

    " special statusbar for special window
    if has("autocmd")
        au FileType qf
                    \ if &buftype == "quickfix" |
                    \ setlocal statusline=%2*%-3.3n%0* |
                    \ setlocal statusline+=\ \[Compiler\ Messages\] |
                    \ setlocal statusline+=%=%2*\ %<%P |
                    \ endif

        fun! FixMiniBufExplorerTitle()
            if "-MiniBufExplorer-" == bufname("%")
                setlocal statusline=%2*%-3.3n%0*
                setlocal statusline+=\[Buffers\]
                setlocal statusline+=%=%2*\ %<%P
            endif
        endfun

        if v:version>=600
            au BufWinEnter *
                        \ let oldwinnr=winnr() |
                        \ windo call FixMiniBufExplorerTitle() |
                        \ exec oldwinnr . " wincmd w"
        endif


    endif

    " Nice window title
    if has('title') && (has('gui_running') || &title)
        set titlestring=
        set titlestring+=%f\ " file name
        set titlestring+=%h%m%r%w " flags
        set titlestring+=\ -\ %{v:progname} " program name
    endif
endif

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comment for C like language
if has("autocmd")
    au BufNewFile,BufRead *.xm,*.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
    au BufNewFile,BufRead *.m setf objc
    au BufNewFile,BufRead *.mm setf objcpp
    au BufNewFile,BufRead *.xm setf objcpp
endif

"My information
ia xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

"Tab configuration
map <leader>tg :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tp :tabp<cr>
map <leader>tn :tabn<cr>
map <leader>b :tabp<cr>
map <leader>n :tabn<cr>

"quickfix
map <leader>qn :cn<cr>
map <leader>qp :cp<cr>
map <leader>qw :ccl<cr>
map <leader>qo :cw<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup
set nowb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
    set fen
endif

if exists("&foldlevel")
    set fdl=0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python script
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set backspace=2
set smarttab
set lbr

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si

"C-style indenting
if has("cindent")
    set cindent
endif

"Wrap line
set wrap

" Vimscript filetype settings ---------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    "autocmd FileType java setlocal foldmethod=indent
    autocmd FileType java ia stfs static final String
augroup END
" }}}

" Vimscript vundle settings ---------------------- {{{
" ****************
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/ListToggle'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'EasyGrep'

Plugin 'Mark--Karkat'
Plugin 'CCTree'
Plugin 'fatih/vim-go'
Plugin 'winmanager--Fox'

Plugin 'The-NERD-tree'
Plugin 'ctrlp.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Auto-Pairs'
Plugin 'ntpeters/vim-better-whitespace'

Plugin 'SirVer/ultisnips'
Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'

Plugin 'DoxygenToolkit.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'abcdnned/vim-java-commenter'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()
filetype plugin indent on
" }}}

"***** airline **********
let g:airline_theme='simple'

"*****nredcommenter**********
let g:NERDSpaceDelims=1
au FileType java let g:NERDAltDelims_java=1

"*****vim-multiple-cursors***
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<S-n>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"*****Ack*******"
nmap <leader>aa :Ack <C-R>=expand("<cword>")<CR> *<CR>
nmap <leader>ai :Ack -i <C-R>=expand("<cword>")<CR> *<CR>
nmap <leader>ap :Ack <C-R>=expand("<cword>")<CR>
nmap <leader>aj :Ack -i <C-R>=expand("<cword>")<CR>

"*****Ycm youcompleteme *******"
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py'
set completeopt=menu
nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoTo<CR>
nnoremap <leader>ji :YcmCompleter GoTo<CR>
nnoremap <F6> :YcmForceCompileAndDiagnostics<CR>

"python解释器路径"
let g:ycm_path_to_python_interpreter='/usr/bin/python'

"*****Eclim*****"
nnoremap <leader>jk :JavaSearch <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>jm :JavaSearchContext<CR>
nnoremap <leader>jc :JavaSearchContext<CR><CR>:ccl<CR>
nnoremap <leader>jv :vsp<CR>:JavaSearchContext<CR><CR>:ccl<CR>
nnoremap <leader>js :sp<CR>:JavaSearchContext<CR><CR>:ccl<CR>
nnoremap <leader>ja :JavaSearchContext -a<CR>
nnoremap <leader>je :JavaCorrect<CR>

let g:EclimCompletionMethod = 'omnifunc'

"*****tagbar*******"
nmap <C-t> :TagbarToggle<CR>

if MySys() == "mac"
    let g:tagbar_ctags_bin="/opt/special/bin/ctags"
endif

let tagbar_left=1
let g:tagbar_type_objc = {
            \ 'ctagstype' : 'ObjectiveC',
            \ 'kinds'     : [
            \ 'i:interface',
            \ 'I:implementation',
            \ 'p:Protocol',
            \ 'm:Object_method',
            \ 'c:Class_method',
            \ 'v:Global_variable',
            \ 'F:Object field',
            \ 'f:function',
            \ 'p:property',
            \ 't:type_alias',
            \ 's:type_structure',
            \ 'e:enumeration',
            \ 'M:preprocessor_macro',
            \ ],
            \ 'sro'        : ' ',
            \ 'kind2scope' : {
            \ 'i' : 'interface',
            \ 'I' : 'implementation',
            \ 'p' : 'Protocol',
            \ 's' : 'type_structure',
            \ 'e' : 'enumeration'
            \ },
            \ 'scope2kind' : {
            \ 'interface'      : 'i',
            \ 'implementation' : 'I',
            \ 'Protocol'       : 'p',
            \ 'type_structure' : 's',
            \ 'enumeration'    : 'e'
            \ }
         \ }

"****************
"nerdtree
"****************
"nmap <silent> <leader>nt :NERDTree<CR>
nmap <silent> <leader>tr :NERDTreeToggle<CR>

"****************
"mark.vim
"****************
nmap <silent> <leader>hl <Plug>MarkSet
vmap <silent> <leader>hl <Plug>MarkSet
nmap <silent> <leader>hh <Plug>MarkClear
vmap <silent> <leader>hh <Plug>MarkClear
nmap <silent> <leader>hr <Plug>MarkRegex
vmap <silent> <leader>hr <Plug>MarkRegex

"***************
"ctrlp.vim
"***************
" MacOSX/Linux
if MySys() == "unix" || MySys() == "mac"
    set wildignore+=*.o,*.so,*.swp,*.zip,*.class,*.obj,.git,.svn,*.jar
else
    " Windows
    set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe,*.class,*.obj,.git,.svn,*.jar
endif

imap <leader>i <Esc>:CtrlP /usr/include<CR>
nmap <leader>i :CtrlP /usr/include<CR>

let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|o|a)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_working_path_mode='a'

"****************
"doxygentoolkit
"****************
let g:DoxygenToolkit_authorName="zhoujinze"
let s:licenseTag="Copyright(C) 2018 "
let s:licenseTag=s:licenseTag."Bonree, All right reserved\<enter>"
let g:DoxygenToolkit_licenseTag=s:licenseTag

" let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_briefTag_funcName="no"
let g:DoxygenToolkit_briefTag_pre = ""
let g:doxygen_enhanced_color=1
let g:DoxygenToolkit_blockHeader=""
let g:DoxygenToolkit_blockFooter=""
let g:DoxygenToolkit_returnTag = "@return "

imap <C-g><C-j> <Esc>:Dox <CR>
nmap <C-g><C-j> :Dox <CR>

"****************
"Project manage
"****************

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
set csprg=/usr/bin/cscope
set csto=1
set cst
set csverb

nmap <leader>ds :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>dg :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>dc :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>dt :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>de :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>df :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>di :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>dd :scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <leader>vs :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>vg :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <leader>vc :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>vt :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <leader>ve :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <leader>vf :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <leader>vi :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <leader>vd :vert scs find d <C-R>=expand("<cword>")<CR><CR>

nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
"nmap <leader>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
"nmap <leader>e :cs find e <C-R>=expand("<cword>")<CR><CR>
"nmap <leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
"nmap <leader>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
"nmap <leader>d :cs find d <C-R>=expand("<cword>")<CR><CR>

endif

"""""""""""""""""""""""""""""
"""project tag manage
"""""""""""""""""""""""""""""
let g:prjbase=".\/."
let g:project_name="vpj"

function CCreateProjectFunc(name)
    let g:project_name = a:name
    {
    }
    let g:session_file = g:prjbase. g:project_name . "\/" . g:project_name . ".vim"
    let g:viminfo_file = g:prjbase. g:project_name . "\/" . g:project_name . ".viminfo"
    let g:cs_file = g:prjbase. g:project_name . "\/" . "cscope.files"
    let g:cs_out = g:prjbase. g:project_name . "\/" . "cscope.out"

    if !isdirectory(g:project_name)
        execute '!mkprj.sh' g:project_name
        execute 'mksession' g:session_file
        execute 'wviminfo' g:viminfo_file
        "execute '!cp' g:prjbase.g:project_name. "\/"."filenametags" ".\/&"
    else
        echo "Project already exist!"
    endif
endfunction

function OOpenProjectFunc(name)
    let l:project_name = a:name
    let l:session_file = g:prjbase. l:project_name . "\/" . l:project_name . ".vim"
    let l:viminfo_file = g:prjbase.l:project_name . "\/" . l:project_name . ".viminfo"
    let l:cs_file = g:prjbase. l:project_name . "\/" . "cscope.files"
    let l:cs_out = g:prjbase. l:project_name . "\/" . "cscope.out"
    let l:tag_file = ".".l:project_name. "\/tags"

    if filereadable(l:cs_file)
        execute 'source' l:session_file
        execute 'rviminfo' l:viminfo_file
        execute 'cs kill -1'
        execute 'cs add' l:cs_out
        "execute 'CCTreeLoadDB' l:cs_out
        let g:LookupFile_TagExpr = "'" . g:prjbase . l:project_name . "/filenametags" . "'"

        execute 'set tags='.l:tag_file
        execute 'set notagrelative'
    else
        echo "Cann't find the project"
    endif
endfunction

function UUpdateProjectFunc(name)
    let l:project_name = a:name
    let l:cs_file = g:prjbase. l:project_name . "\/" . "cscope.files"
    let l:cs_out = g:prjbase. l:project_name . "\/" . "cscope.out"

    execute '!mkcodetags.sh' l:project_name
    execute 'cs kill -1'
    execute 'cs add' l:cs_out
    let g:LookupFile_TagExpr = "'" . g:prjbase . l:project_name . "/filenametags" . "'"
    "execute 'CCTreeLoadDB' g:cs_out
endfunction

function LoadProjectDbFunc(name)
    let l:project_name = a:name
    let l:cs_out = g:prjbase. l:project_name . "\/" . "cscope.out"
    execute 'CCTreeLoadDB' l:cs_out
endfunction

function CCloseProjectFunc(name)
    let l:project_name = a:name
    let l:viminfo_file = g:prjbase. l:prjname. "\/" . l:prjname. ".viminfo"
    echo l:viminfo_file
    execute 'wviminfo'  l:viminfo_file
    execute 'qa'
endfunction

:command -nargs=1 OO :call OOpenProjectFunc(<f-args>)
:command -nargs=1 GG :call CCreateProjectFunc(<f-args>)
:command -nargs=1 UU :call UUpdateProjectFunc(<f-args>)
:command -nargs=1 QQ :call CCloseProjectFunc(<f-args>)
:command -nargs=1 LL :call LoadProjectDbFunc(<f-args>)

