
" http://sontek.net/turning-vim-into-a-modern-python-ide
" https://github.com/skwp/dotfiles/blob/master/vimrc
" keepcase: http://www.vim.org/scripts/script.php?script_id=6
" http://items.sjbach.com/319/configuring-vim-right
" http://learnvimscriptthehardway.stevelosh.com/chapters/01.html
" http://zzapper.co.uk/vimtips.html
" https://github.com/nvie/vimrc
" https://github.com/carlhuda/janus/blob/master/janus/vim/core/before/plugin/settings.vim


" When your .vimrc file is sourced twice, the autocommands will appear twice.
" To avoid this, put this command in your .vimrc file, before defining
" autocommands 
" autocmd!	" Remove ALL autocommands for the current group.

""" Before Bundles
set nocompatible              " Don't be compatible with vi
filetype off

""" Bundle Management
" PATHOGEN bundle/plugin manager
" Disable pathogen plugins
" To disable a plugin, add it's bundle name to the following list
" let g:pathogen_disabled = []
"" call add(g:pathogen_disabled, 'rope-vim') " python failing to import os. :-(
" call add(g:pathogen_disabled, 'AutoComplPop')
" Pathogen configuration
" To enable filetype specific plugin loading, make sure filetype is off
" before starting pathogen.
" runtime bundle/vim-pathogen/autoload/pathogen.vim
" call pathogen#infect()
" call pathogen#helptags()

" UNBUNDLE bundle/plugin manager
runtime bundle/vim-unbundle/unbundle.vim
" to manually reload bundles (or just new bundles?) invoke ':Unbundle'

""" After Bundles
syntax on                     " syntax highlighing
filetype plugin indent on     " filetype detection, plugins, and indent files.

""" Basic settings 
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
" colorscheme summerfruit256
" colorscheme Tomorrow-Night " https://github.com/chriskempson/tomorrow-theme
colorscheme Tomorrow " https://github.com/chriskempson/tomorrow-theme
" colorscheme desert
" colorscheme solarized         " set a nice colorscheme. 'desert' is good too.
set background=light          " We are using dark background in vim
" set background=dark
set guifont=Monaco:h13        " Set the default font and size
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
" <Tab> completes to the longest match and list possible completions.
" set wildmode=list:longest   
" <Tab> completes to the longest match.  A second <Tab> lists possible completions, like emacs.
set wildmode=longest,list
" set wildmode=full           " <Tab> cycles between all matching choices.
set encoding=utf-8
" set relativenumber            " display line numbers relative to current line.
" useful for debugging autocmd lines.
" set verbose=9

let mapleader = ","             " change the leader to be a comma vs slash
let maplocalleader = "\\"

" Hard wrap at 80 columns
" set wrap
" set textwidth=80
" Soft wrap line at 80 columns?
" http://vim.wikia.com/wiki/Word_wrap_without_line_breaks
" set linebreak
" set display+=lastline


""" Plugin Configuration
let g:NERDSpaceDelims = 1 " Add a space after the comment character.


""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=4             " Keep N context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
" set smartindent             " use smart indent if there is no indent file
set tabstop=2               " <tab> inserts 2 spaces 
set shiftwidth=2            " but an indent level is 2 spaces wide.
set softtabstop=2           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
" let arrow keys wrap around line endings.  
" http://stackoverflow.com/questions/2574027/automatically-go-to-next-line-in-vim
" letting h,l wrap is supposed to possibly break some plugins, etc.  Beware.
set whichwrap=h,l,b,s,<,>,[,]
" Make j and k play nicely with wrapped lines.  They will move down/up a single
" line even when the current/previous line wraps around.
nnoremap j gj
nnoremap k gk


""" Searching and Patterns
set showmatch               " Briefly jump to a paren once it's balanced
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently 
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
set statusline=[%l,%v\ %P%M]\ %f\ %r%h%w\ (%{&ff})\ %{fugitive#statusline()}
" set statusline+=%y         " add filetype to statusline
" highlight column 80, to improve my compliance via visual feedback
" colorcolumn not supported in vim < 7.3.
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns
if exists('+colorcolumn')
  set colorcolumn=80
endif
" List chars
set list                          " Show invisible characters
" displays tabs with :set list & displays when a line runs off-screen
" set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
set listchars=""                  " Reset the listchars
" set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars=tab:>-              " show tab as '>---'
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
                                  " off and the line continues beyond the right of the screen


""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/?#making-vim-more-useful
" The modelines bit prevents some security exploits having to do with modelines in files.
set modelines=0             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.


""" Turn Off Swap Files
set noswapfile
set nobackup
set nowritebackup


" This makes vim act like other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

" Create missing parent directories of the file being saved.
" Usage: :W
function! WriteCreatingDirs()
    execute ':silent !mkdir -p %:h'
    write
endfunction
command! W call WriteCreatingDirs()


" send the current paragraph or visually selected text to a command and
" see the output on the command line.
" http://stackoverflow.com/questions/2575545/vim-pipe-selected-text-to-shell-cmd-and-receive-output-on-vim-info-command-line
vnoremap <leader>cp2 <esc>:'<,'>w !python2<CR>
nnoremap <leader>cp2 mqvip<esc>`q:'<,'>w !python2<CR>
vnoremap <leader>cp3 <esc>:'<,'>w !python3<CR>
nnoremap <leader>cp3 mqvip<esc>`q:'<,'>w !python3<CR>
vnoremap <leader>cb <esc>`q:'<,'>w !bash<CR>
nnoremap <leader>cb mqvip<esc>`q:'<,'>w !bash<CR>


" turn on/off spell checking
nnoremap <leader>sp :setlocal spell! spelllang=en_us<cr>

" Preview a markdown file in the browser in Mac OS X. Assuems you have my
" markdown preview binary in your path.
" nnoremap <leader>mdp :silent :!markdownpreview %<cr>
" write the buffer into the markdown command
nnoremap <leader>mdp :silent :w !markdownpreview<cr>
" render selected markdown text as html in a browser. 
" when typed out in visual mode looks like :'<,'>w !{cmd}
" TODO: make silent.  silent dies when given a range.
vnoremap <leader>mdp :w !markdownpreview<cr>

" Make a group of lines a markdown list
" todo: toggle "list"
" todo: do '*' or '-'
" todo: handle nested lists
" todo: unmake a list.
function! ConvertToMarkdownList()
  " execute "s/^/-\ "
  execute "normal 0i- \<esc>"
endfunction
nnoremap <Leader>- :call ConvertToMarkdownList()<CR>
vnoremap <Leader>- :call ConvertToMarkdownList()<CR>

" Make a group of lines a markdown quoted block
" todo: toggle "quote"
" todo: handle nested quotes
" todo: unmake a quote.
function! ConvertToMarkdownQuote()
  execute "normal 0i> \<esc>"
endfunction
nnoremap <Leader>> :call ConvertToMarkdownQuote()<CR>
vnoremap <Leader>> :call ConvertToMarkdownQuote()<CR>

" insert a blank line above or below the current line.
nnoremap + maO<esc>`a
nnoremap - mao<esc>`a

" don't outdent hashes. Type 'X<C-V><C-H>#'. See :help smartindent
inoremap # X#

" Paste from clipboard
map <leader>p "+p

" hide matches on <leader>space
nnoremap <leader><space> :nohlsearch<cr>

" save wear and tear on left pinky
" inoremap jk <esc>

" sudo write this file.
cmap w!! w !sudo tee % >/dev/null

" Make it easier to edit and source .vimrc
" Edit vimrc
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
" Reload Vimrc
map <silent> <leader>sv :silent :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" make Y work like D, C, etc.
nnoremap Y y$
" change working directory to dir of current file
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
" autochdir does not work with vim in Mac OS X Terminal.app.  
" set autochdir
autocmd BufEnter * silent! lcd %:p:h

""" emacs friendly mappings  
" delete a character
inoremap <c-d> <del>
" learn to use x instead.  nnoremap <c-d> <del>
" move to end of line
inoremap <c-e> <esc>A
" move to beginning of line
inoremap <c-a> <esc>I
" cut to end of line
" problems w/ c-k.  If cursor is before first character of the line, it
" does not back up when entering normal mode, so
" this does not cut the first character.  If cursor is after the last
" character of the line, this fails to go forward on character and the
" command fails.
" inoremap <c-k> <esc>l"kd$A

" Remove trailing whitespace on <leader>S
nnoremap <leader>S :%s/\s\+$//<cr>:let @/=''<CR>


" Reselect visual block after indent/outdent.  Hasten mutliple indents.
" http://vimbits.com/bits/20
vnoremap < <gv
vnoremap > >gv


" make a hashbar above the current line the same length as the line.
" e.g. #########
"      # COMMENT
nnoremap <leader># mq0yyPv$r#`q
" make the current line a reStructuredText section
" nnoremap <leader>s1 0yy:pu<cr>v$r=yykPjjo<esc>
" nnoremap <leader>s2 0yy:pu<cr>v$r-yykPjjo<esc>
nnoremap <leader>s1 0yy:pu<cr>v$r=o<esc>
nnoremap <leader>s2 0yy:pu<cr>v$r-o<esc>
nnoremap <leader>s3 0yy:pu<cr>v$r~o<esc>
nnoremap <leader>s4 0yy:pu<cr>v$r`o<esc>
nnoremap <leader>s5 0yy:pu<cr>v$r.o<esc>



" Go to the last day in my notes file.
" example of text marking the start of a day:
" ========== 2012-02-14 ==========
" see :help function for more on writing functions.
" see :help normal and :help execute on how to execute normal mode commands
" in a function.
" Some links that were helpful in restoring the search pattern.  Basically,
" it is restored automatically when running commands in a function.
" http://stackoverflow.com/questions/1385196/vim-restore-last-search-pattern
" http://stackoverflow.com/questions/10631881/executing-commands-in-normal-mode-inside-vim-function
" http://vim.wikia.com/wiki/Execute_commands_without_changing_the_search_register
function! GoToLastDay()
  execute "normal \<Esc>G?========== \\d\\d\\d\\d-\\d\\d-\\d\\d ==========\<CR>j"
endfunction
nnoremap <Leader>6 :call GoToLastDay()<CR>
" Go to next / previous day.
nnoremap <silent> <leader>td /========== \d\d\d\d-\d\d-\d\d ==========<CR>

" Go to next or previous [todo] item in my notes file.
" nnoremap <Leader>t <Esc>/\[todo\]<CR>
" Go to next [todo], [health], [timeoff], or other item in my notes file.
nnoremap <silent> <leader>to /^\[[^\]]\+\]<CR>


""" WINDOWS

" make a new vertical-split window and go to it.
nnoremap <leader>w <C-w>v<C-w>l

" Move the cursor to the window left of the current one
noremap <silent> <leader>h :wincmd h<cr>
" Move the cursor to the window below the current one
noremap <silent> <leader>j :wincmd j<cr>
" Move the cursor to the window above the current one
noremap <silent> <leader>k :wincmd k<cr>
" Move the cursor to the window right of the current one
noremap <silent> <leader>l :wincmd l<cr>
" Close the window below this one
noremap <silent> <leader>cj :wincmd j<cr>:close<cr>
" Close the window above this one
noremap <silent> <leader>ck :wincmd k<cr>:close<cr>
" Close the window to the left of this one
noremap <silent> <leader>ch :wincmd h<cr>:close<cr>
" Close the window to the right of this one
noremap <silent> <leader>cl :wincmd l<cr>:close<cr>
" Close the current window
noremap <silent> <leader>cc :close<cr>
" Move the current window to the right of the main Vim window
noremap <silent> <leader>ml <C-W>L
" Move the current window to the top of the main Vim window
noremap <silent> <leader>mk <C-W>K
" Move the current window to the left of the main Vim window
noremap <silent> <leader>mh <C-W>H
" Move the current window to the bottom of the main Vim window
noremap <silent> <leader>mj <C-W>J


" ===========================================================
" FileType specific changes
" ============================================================

" set soft-wrapping for txt files.
autocmd BufNewFile,BufRead *.txt setlocal wrap nolist linebreak textwidth=0 
autocmd BufNewFile,BufRead *.md setlocal wrap nolist linebreak textwidth=0 

" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
" set tabs to be 4 spaces in python.
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" Don't let pyflakes use the quickfix window
let g:pyflakes_use_quickfix = 0




" VIM TIPS
"
" Keyboard Macros
" http://www.grok2.com/blog/2010/05/13/creating-and-using-keyboard-macros-record-macro-play-macro-to-record-and-playback-keystrokes-in-vim/
" Start: in normal mode type 'qa', where a is a register.
" Stop: enter normal mode and type 'q'
" Run: in normal mode, type '@a' where a is a register.
" Repeat last macro. type '@@'
" 


