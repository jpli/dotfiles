" Vim initialization script

" This must come first
set nocompatible

" vim can use 10 files to save marks, global marks are stored, each register
" can have no more than 500 lines to save in viminfo file, convert the text in
" viminfo file to current encoding
set viminfo='10,f1,<500,c

" Define ',' as the special string <leader>
let mapleader = ","
let g:mapleader = ","

" Automatically read the file content when it's modified outside vim
set autoread

" Don't generate backup when overwrite a file
set nobackup
" Make a backup before overwriting a file, remove it after the file was
" successfully written
set writebackup
" Use a swapfile for the buffer
set swapfile

" Use a very simple GUI, no menu, no scroll bar, no toolbar
" GUI fonts are specified
if has("gui_running")
  set guioptions=ai
  if has("win32")
    set guifont=Courier_New:h11:cANSI
    set guifontwide=NSimSun:h11:cGB2312
  else
    set guifont=WenQuanYi\ Zen\ Hei\ Mono\ 12
  endif
endif


" Always use utf-8 as vim's internal encoding, since (almost) all encodings
" can be converted to utf-8, this can save the user from much troubles caused
" by encoding, eg. vim displays a lot of '^@' when displaying an utf-16le file
" if using cp936 as the internal encoding.
" More importantly this can prevent LOSS OF INFORMATION when vim fails to
" convert some characters to the internal encoding, which is unlikely to
" happen for utf-8.
set encoding=utf-8

" In windows, gvim may display gabbled menu and messages when encoding is
" utf-8, they can also be set to zh_CN.UTF-8
set langmenu=en_US.UTF-8
language message en_US.UTF-8 

" Set the list of possible fileencodings in an order that the proper
" fileencoding can be detected for the file being edited
" usc-bom is a very strict encoding, put it first latin1 is a very loose
" encoding, put it last
" utf-8 comes second, it is a relatively strict encoding
" cp936, gb18030 are alike, the later covers a slightly wider range of
" characters, gb2312 is a subset of cp936, use cp936 for all gb2312 files
" euc-jp and euc-kr are unlikely to be detected when put behind cp936, it's
" not a big issue since they are rarely encounted.
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Characters with East Asian Width Class Ambiguous will have twice the width
" of ASCII characters, xterm should start with -cjk_width option to enable it
" haven't figured out how to make make this work for rxvt-unicode
" Don't set this option, xterm and rxvt-unicode does not display East Asian
" Ambiguous characters properly when they haven't turned on options like
" -cjk_width, xterm also behaves funny when trying to delete an East Asian
"  Ambiguous character with -cjk_width option turned on.
" set ambiwidth=double

" Choose unix to be the primary fileformat
set fileformats=unix,dos,mac

" Color scheme
colorscheme desert " Warm

" Fortran
let fortran_have_tabs=1

syntax on

" Force gVim to use black background, overridding what has been set in
" colorscheme, this command is used with desert color scheme, and after the
" syntax on command
highlight Normal guibg=Black guifg=White
highlight NonText guibg=Black guifg=White

" Use 2 screen lines for the command line
set cmdheight=2
" Show the status line when there are more than one windows
set laststatus=2
" Status Line format settings
set statusline=[%n]\ %<%F\ %((%1*%M%*%R%Y)%)\ %{HasPaste()}(@%{getcwd()})\ %=%-19(LINE[%l/%L]\ COL[%c%V]%)\ ascii['0x%02B']\ %P
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
" Show information about the current cursor position in a file
" This option only effects the output of Ctrl+G since laststatus=2 and
" statusline is set
set ruler


" Ignore case when searching
set ignorecase
" Don't ignore case when search pattern contains upper-case characters
set smartcase
" Highlight searched content
set hlsearch
" Don't show searched content while typing.
set noincsearch
" Turn magic option on, which is the default, so that user can have control
" over whether a character (preceded by a backslash or not) has special
" meaning
set magic
" Disable highlight for hlsearch when <leader><cr> is pressed
map <silent> <leader><cr> :nohlsearch<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


" Allow backspacing over autoindent, line breaks and the start of insert
set backspace=indent,eol,start
" Allow <BS> and <Left> (<Space> and <Right>) key in normal and visual mode,
" <Left> (<Right>) key in insert and replace mode to move to previous (next)
" line on the first (last) character of the line
set whichwrap=b,s,<,>,[,]
" Vim will try its best not to break inside a word
"set linebreak
" Disable linebreak
set nolinebreak
" Allow vim to break a line at a multi-byte character above 255 (eg. a Chinese
" character)
" When joining lines, don't insert a space before or after a multi-byte
" character.
set formatoptions+=mM
" Treat long lines as break lines when moving up/down
map <Down> gj
map <Up>   gk
" Allow % to switch between Chinese-specific matchpairs
set matchpairs+=（:）,《:》,「:」,【:】


" Number of spaces to use for each step of (auto)indent
set shiftwidth=4
" Number of spaces of a <Tab>
set tabstop=4
" Convert <Tab> to spaces
set expandtab
" Copy indent from current line when starting a new line
set autoindent
" Do smart autoindenting when starting a new line
set smartindent

" Keep at least 5 lines above and below the cursor when scrolling up and down
set scrolloff=5

" Enable mouse for all modes (except insert mode) when mouse is available
if has("mouse")
  set mouse=nvch
endif

" Show a single-line menu of options when using auto-completion
set wildmenu

" Enable num keys in insert mode
imap <Esc>Oq 1
imap <Esc>Or 2
imap <Esc>Os 3
imap <Esc>Ot 4
imap <Esc>Ou 5
imap <Esc>Ov 6
imap <Esc>Ow 7
imap <Esc>Ox 8
imap <Esc>Oy 9
imap <Esc>Op 0
imap <Esc>On .
imap <Esc>OQ /
imap <Esc>OR *
imap <Esc>Ol +
imap <Esc>OS -


"
" Auto commands settings
"
if has("autocmd")
  " Enable file type detection.
  " Automatically load plugin files for a detected filetype if there are any.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  "
  " In case indent settings cause trouble when paste a file, type
  " ':set paste' before paste a file, type ':set nopaste' when paste is done.
  filetype plugin on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    " Cause all the autocmd in this group to use autocmd!
    " autocmd! can avoid duplicated auto command when a config file is sourced
    " for the second time
    autocmd!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " Markdown
    autocmd BufRead,BufNewFile *.{md,mkd} set filetype=markdown

    autocmd FileType make setlocal tabstop=8 noexpandtab
    autocmd FileType vim,html,xhtml setlocal shiftwidth=2 tabstop=2

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  augroup END "augroup vimrcEx
endif " has("autocmd")


"
" User-defined commands
"
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

" Substitute ampersand, less-than and greater-than characters into html code
function! Sub_alg()
  snomagic/&/&amp;/ge " This must come first
  snomagic/</&lt;/ge
  snomagic/>/&gt;/ge
endfunction


function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
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
        return '(PASTE) '
    endif
    return ''
endfunction

" Reference
"   http://edyfox.codecarver.org/html/_vimrc_for_beginners.html (2013-10-06)
"   http://amix.dk/vim/vimrc.html
