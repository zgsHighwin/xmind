"set clipboard+=unnamedplus
"set cb=unnamedplus
"设置鼠标
"set mouse=a
" 显示行号
" set number
set nu
set rnu
" 显示标尺
"set ruler
" 历史纪录
set history=10000
" 输入的命令显示出来，看的清楚些
set showcmd
" 状态行显示的内容
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" 启动显示状态行1，总是显示状态行2
set laststatus=2
" 语法高亮显示
syntax on
set fileencodings=utf-8,gb2312,gbk,cp936,latin-1
set fileencoding=utf-8
set termencoding=utf-8
set fileformat=unix
set encoding=utf-8
set path+=**
" 配色方案
" blue       delek      evening    macvim     pablo      shine      zellner
" darkblue   desert     industry   morning    peachpuff  slate
" default    elflord    koehler    murphy     ron        torte
syntax enable
set background=dark
colorscheme evening 
" colorscheme delek 
" 指定配色方案是256色
set t_Co=256

set wildmenu

" 去掉有关vi一致性模式，避免以前版本的一些bug和局限，解决backspace不能使用的问题
set nocompatible
set backspace=indent,eol,start
set backspace=2

" 启用自动对齐功能，把上一行的对齐格式应用到下一行
set autoindent

" 依据上面的格式，智能的选择对齐方式，对于类似C语言编写很有用处
set smartindent

" vim禁用自动备份
set nobackup
set nowritebackup
set noswapfile

" 用空格代替tab
set expandtab

" 设置显示制表符的空格字符个数,改进tab缩进值，默认为8，现改为4
set tabstop=4

" 统一缩进为4，方便在开启了et后使用退格(backspace)键，每次退格将删除X个空格
set softtabstop=4

" 设定自动缩进为4个字符，程序中自动缩进所使用的空白长度
set shiftwidth=4

" 设置帮助文件为中文(需要安装vimcdoc文档)
set helplang=cn

" 显示匹配的括号
set showmatch

" 文件缩进及tab个数
au FileType html,python,vim,javascript setl shiftwidth=4
au FileType html,python,vim,javascript setl tabstop=4
au FileType java,php setl shiftwidth=4
au FileType java,php setl tabstop=4
" 高亮搜索的字符串
set hlsearch

" 检测文件的类型
filetype on
filetype plugin on
filetype indent on

" C风格缩进
set cindent
set completeopt=longest,menu

command! MakeTags !ctags -R .
" Use ^] to jump to tag under cursor
" Use g ^] for ambiguous tags
" Use ^t to jump back up the tag stack

" 功能设置

" 去掉输入错误提示声音
set noeb
" 自动保存
set autowrite
" 突出显示当前行 
set cursorline
" 突出显示当前列
"set cursorcolumn
"设置光标样式为竖线vertical bar
" Change cursor shape between insert and normal mode in iTerm2.app
"if $TERM_PROGRAM =~ "iTerm"
let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Vertical bar in insert mode
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
"endif
" 共享剪贴板
set clipboard+=unnamed
" 文件被改动时自动载入
set autoread
" 顶部底部保持3行距离
set scrolloff=3
let $BASH_ENV = "~/.bash_profile"
"call plug#begin()
"Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
"call plug#end()

execute pathogen#infect()
"Custom Key
nnoremap gh ^
nnoremap gl $
nmap <C-n> :NERDTreeToggle<CR>
autocmd BufEnter * lcd %:p:h
autocmd BufWritePost $MYVIMRC source $MYVIMRC
autocmd FileType python noremap <buffer> <leader>f :call Autopep8()<CR>

let g:jedi#completions_command = "<c-p>"

""""""""""""""""""""""
    "Quickly Run
    """"""""""""""""""""""
    map <c-x> :call CompileRunGcc()<CR>
    func! CompileRunGcc()
        exec "w"
if &filetype == 'c'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'cpp'
            exec "!g++ % -o %<"
            exec "!time ./%<"
elseif &filetype == 'java'
            exec "!javac %"
            exec "!time java %<"
elseif &filetype == 'sh'
            :!time bash %
elseif &filetype == 'python'
            exec "!time python3 %"
elseif &filetype == 'ruby'
            exec "!time ruby %"
elseif &filetype == 'html'
            exec "!chrome % &"
elseif &filetype == 'go'
    "        exec "!go build %<"
            exec "!time go run %"
elseif &filetype == 'mkd'
            exec "!~/.vim/markdown.pl % > %.html &"
            exec "!chrome %.html &"
endif
    endfunc
    
"inoremap <Space><Space> <Esc>/<Enter>"_c4l
autocmd filetype html inoremap ;i <em></em><Space><++><Esc>FeT>i
" custom shortcut for Android start
autocm  FileType java nnoremap fd ifindViewById(R.id.)<Esc>T.i
autocm  FileType java nnoremap fdt i(TextView)findViewById(R.id.)<Esc>T.i
autocm  FileType java nnoremap fdi i(ImageView)findViewById(R.id.)<Esc>T.i
"custom shortcut for Android end
" Spell-Check set to F6
map <F7> :setlocal spell! spelllang=en_us<CR>
"youCompleteMeConfig
" 自动补全配置
set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"youcompleteme  默认tab  s-tab 和自动补全冲突

let g:ycm_python_binary_path = '/Library/Frameworks/Python.framework/Versions/3.8/bin/python3' 
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
"let g:ycm_confirm_extra_conf= '$HOME/.vim/ycm_extra_conf.py' "关闭加载.ycm_extra_conf.py提示
let g:ycm_confirm_extra_conf= '/Users/zgs/.vim/ycm_extra_conf.py'

let g:ycm_collect_identifiers_from_tags_files=1 " 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=1 " 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0  " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>    "force recomile with syntastic
"nnoremap <leader>lo :lopen<CR> "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
inoremap <leader><leader> <C-x><C-o>
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_key_list_previous_completion = ['<S-TAB>']
let g:ycm_key_list_stop_completion = ['<C-y>']
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0

nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
"ack的配置
let g:ackprg = 'ag --nogroup --nocolor --column'
"CtrlP的配置
set runtimepath^=~/.vim/bundle/ctrlp.vim
" python语法检查
let python_highlight_all=1
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checkers=['flake8']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
