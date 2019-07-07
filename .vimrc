set nocompatible
filetype off

" #################### Vundle setup ####################
let vinstall=0
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let vinstall=1
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" #################### Bundles ####################
Plugin 'VundleVim/Vundle.vim'
"Bundle 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Raimondi/delimitmate'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'luochen1990/rainbow'
Plugin 'klen/python-mode'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'flazz/vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'majutsushi/tagbar'
Plugin 'MarcWeber/vim-addon-local-vimrc'
Plugin 'PProvost/vim-ps1'
Plugin 'jeetsukumaran/vim-buffersaurus'
Plugin 'fatih/vim-go'
Plugin 'MattesGroeger/vim-bookmarks'

if vinstall == 1
    :BundleInstall
endif

" #################### Vim settings ####################
"turn filetype back on
filetype plugin indent on

"Theme
syntax on
set background=dark
colorscheme solarized
set cursorline
set cursorcolumn

"General/misc settings
set number              " Turn on line numbering
set relativenumber      " Make line numbering relative to the current line
set t_Co=256            " Make sure vim is using 256 colors
let mapleader=","       " <leader> key, change to your liking
set hidden              " Background unsaved buffers
set mouse=a             " Turn on mouse support
set showcmd             " Display commands as they are typed
set cmdheight=1         " Force the commandbar height to be 1
set wildchar=<TAB>      " Path/file expansion in colon mode
set backspace=2         " Make backspace act normally
set colorcolumn=80

"Remember things about sessions
autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|     endif
let g:session_autosave = 1
let g:session_autoload = 1

"Relative line numbering
if exists('+relativenumber')
    set relativenumber  "Display how far away each line is from the current one by default
    " Switch to absolute line numbers whenever Vim loses focus
    autocmd FocusLost * :set number
    autocmd FocusGained * :set relativenumber
    " Use absolute line numbers when in insert mode and relative numbers when in normal mode
    autocmd InsertEnter * :set norelativenumber | set number
    autocmd InsertLeave * :set relativenumber
else
    set number          " Show absolute line numbers
endif

"Brackets
set showmatch           " Show matching brackets
set matchtime=1         " How many tenths of a second to show matching paren with showmatch set
let g:matchparen_insert_timeout=5   " Default is 60 will lag for extremely large files

"Tab/space/indentation settings
set expandtab           " Use spaces on tab
set shiftwidth=4        " Number of spaces >> and << will indent
set softtabstop=4       " Number of spaces the expanded tab will take up
set tabstop=8           " Number of columns a real tab will take up
set smarttab            " Backspace/tab will indent to next/previous tabwidth
set wrap                " Wraps text to the next line when it reaches the end of the screen
set autoindent          " Automatically indent where possible
set shiftround          " When at 3 spaces and hit > ... go to 4, not 5
set listchars=tab:>-,trail:-    ",eol:¬ or eol:$

"Searching options
set ignorecase          " Ignore case when searching
set smartcase           " If there are caps, go case-sensitive
set infercase           " Case inferred by default
set hlsearch            " Highlight search things
set incsearch           " Make search act like search in modern browsers

"Swap saving settings
if !isdirectory(expand('$HOME/.vim-bak/swap'))
    silent !mkdir -p ~/.vim-bak/swap
endif
set swapfile
set directory^=$HOME/.vim-bak/swap//

"File backup saving settings
if !isdirectory(expand('$HOME/.vim-bak/backup'))
    silent !mkdir -p ~/.vim-bak/backup
endif
set backup
set writebackup
set backupdir=~/.vim-bak/backup

"Undo history saving settings
if !isdirectory(expand('$HOME/.vim-bak/undo'))
    silent !mkdir -p ~/.vim-bak/undo
endif
set undofile
set undodir^=$HOME/.vim-bak/undo//

"Spellcheck
if version >= 700
    set spl=en spell
    set nospell
endif

"Folds
syn sync fromstart
set foldenable
set foldmethod=syntax
set foldlevel=20
set foldnestmax=10
autocmd FileType python set foldmethod=indent

"Ignore this list of file extensions
set wildignore=*.bak
set wildignore+=*.sw?                               " Vim swap files
set wildignore+=*.DS_Store                          " OS X bullshit
set wildignore+=*.spl                               " Compiled spelling word lists
set wildignore+=*.bmp,*.gif,*.jpg,*.jpeg,*.png      " Binary images
set wildignore+=.hg,.git,.svn                       " Version control
set wildignore+=*.orig                              " Merge resolution files
set wildignore+=*.dll,*.exe,*.o,*.obj,*.manifest    " Compiled object files
set wildignore+=*.pyc                               " Python byte code
set wildignore+=migrations                          " Django migrations
set wildignore+=*.luac                              " Lua byte code
set wildignore+=*.aux,*.out,*.toc                   " LaTeX intermediate files

" #################### Key Maps ####################
nnoremap <leader>p :set nopaste!<CR>
nnoremap <leader>s :set nospell!<CR>
nnoremap <leader>S :SyntasticReset<CR>
nnoremap <silent> <C-l> :nohl<CR><C-l>
nnoremap <leader>. :bnext<CR>
nnoremap <leader>m :bprev<CR>
nnoremap <leader>q :bnext <BAR> bd#<CR>
nnoremap <leader>t :enew<CR>
nnoremap <leader>l :ls<CR>
nnoremap <leader>T :call TabToggle()<CR>
nmap <leader>n :call NERDTreeToggleOrFocus()<CR>
map \ <Plug>(easymotion-prefix)
nnoremap <leader>g :call Dirgrep("-i")<CR>
nnoremap <leader>G :call Dirgrep("")<CR>
inoremap <S-Tab> <C-O>:bnext<CR>
nnoremap <S-Tab> :bnext<CR>
:command! WQ wq
:command! Wq wq
:command! Fuck execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
:command! Fuckq execute 'silent! write !sudo tee % >/dev/null' <bar> edit! <bar> q
:command! W w
:command! Q q
nnoremap ; :
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
nnoremap <leader>/ :call BsgrepRun(" ")<CR>
nnoremap <leader>? :call BsgrepRun("!")<CR>

" #################### Plugin Settings and functions ####################
"Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='lucius'

"Ctrlp settings
let g:ctrlp_working_path_mode = 'r'

"Ultisnips commands
let g:UltiSnipsExpandTrigger="<C-g>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<C-a>"

"Vim bookmarks settings
let g:bookmark_manage_per_buffer = 1
let g:bookmark_auto_save_file = expand('$HOME/.vim/bookmarks')

" Jedi-Vim Settings
let g:jedi#use_tabs_not_buffers = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#popup_select_first=0
let g:jedi#popup_on_dot = 0
autocmd FileType python let b:did_ftplugin = 1
autocmd FileType python let b:did_ftplugin = 1

"YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"Pymode
let g:pymode_lint_ignore = "E501,W0401,E262,E261"
let g:pymode_rope_lookup_project = 0
let g:pymode_rope = 0

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Local vimrc plugin config
let g:local_vimrc = {'names':['.vimrc', '.vimrc.local'],'hash_fun':'LVRHashOfFile'}"

"Rainbow parentheses
let g:rainbow_active = 1

" #################### Misc functions ####################
"grep R(i)In in current dir
function! Dirgrep(arg)
    let search = input("Search term or regex: ")
    if search != ""
        if executable("rg")
            exec ':!rg ' . a:arg . ' "' . search . '" ' . getcwd()
        else
            exec ':!grep -RIn ' . a:arg . ' "' . search . '" ' . getcwd()
        endif
    else
        echoerr "Search cannot be blank"
    endif
endfunction

"Toggle tabs or spaces
function TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    set noexpandtab
  else
    set shiftwidth=4
    set softtabstop=4
    set expandtab
  endif
endfunction

"Nerd tree toggle/focus function
function! NERDTreeToggleOrFocus()
    if expand("%") =~ "NERD_tree"
        :NERDTreeToggle
    else
        call NERDTreeFocus()
    endif
endfunction

"Bsgrep prompt
function! BsgrepRun(arg)
    let search = input("Search term or regex: ")
    if search != ""
        exec ':Bsgrep' . a:arg . ' ' . search
    else
        echoerr "Search cannot be blank"
    endif
endfunction
