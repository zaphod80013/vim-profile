"--------------------------------------------------------------------------------------------------
"	Enable Vim Features
"--------------------------------------------------------------------------------------------------

set nocompatible								" Turn off vi compatability
set encoding=utf-8							" set default encoding to UTF-8
scriptencoding utf-8							" Assume this script is utf-8 encoded

"--------------------------------------------------------------------------------------------------
"	Colour Management
"--------------------------------------------------------------------------------------------------
"
" Create colours for the status line
"
" Warning autocmd is additive and will create duplicates, using an augroup
" allows us to redefine rather than add. The 'autocmd!' is used to clear the
" group before adding, thus avoiding duplicates. 
"
augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight User1 ctermbg=11 ctermfg=00 cterm=NONE
                      \ | highlight User2 ctermbg=02 ctermfg=00 cterm=NONE
                      \ | highlight User3 ctermbg=11 ctermfg=00 cterm=NONE
                      \ | highlight User4 ctermbg=05 ctermfg=15 cterm=NONE
augroup END

"--------------------------------------------------------------------------------------------------
"	File Type Management
"--------------------------------------------------------------------------------------------------

filetype on                         " Enable file type recognition
filetype indent on					" load type specific indent files from .../indent/<>.vim
filetype plugin on                  " load type specific operations from .../plugin/<>.vim
syntax enable                       " load type specific syntax rules from .../syntax/<>.vim

augroup Python
   autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
   autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
augroup END

augroup Markdown
   autocmd!
   autocmd BufNewFile,BufRead *.md set filetype=markdown
   autocmd FileType markdown set cursorline
   autocmd FileType markdown set conceallevel=2
   autocmd FileType markdown setlocal spell spelllang=en_us
   autocmd FileType markdown execute ':Limeligh'

augroup END

"--------------------------------------------------------------------------------------------------
" Custom Functions
"--------------------------------------------------------------------------------------------------
"
function! ProfileHelp()
    let l:vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    if expand('%:t') == 'ProfileCheatSheet.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . l:vimdir . '/cheatsheets/ProfileCheatSheet.md'        
        echon ''
    endif    
endfunction

function! AnsibleHelp()
    let l:vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    if expand('%:t') == 'AnsibleCheatSheet.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . l:vimdir . '/cheatsheets/AnsibleCheatSheet.md'        
        echon ''
    endif    
endfunction

function! UnicodeHelp()
    let l:vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    if expand('%:t') == 'UnicodeCharacters.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . l:vimdir . '/cheatsheets/UnicodeCharacters.md'        
        echon ''
    endif    
endfunction

function! LinuxHelp()
    let l:vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
    if expand('%:t') == 'LinuxCheatSheet.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . l:vimdir . '/cheatsheets/LinuxCheatSheet.md'        
        echon ''
    endif    
endfunction

"
" Function to display state of number setting
"
function! Number()
   let l:number = &number
   return l:number == 'nonumber'?'NUM':'num'
endfunction

"
" Function to display state of number setting
"
function! List()
   let l:list = &list
   return l:list == 'nonlist'?'VIS':'vis'
endfunction

"
" Function to display state of expandtab setting
"
function! ExpandTab()
   let l:expand = &expandtab
   return l:expand == 'noexpandtab'?'TAB':'tab'
endfunction

"
" Function to display state of wrap
"
function! Wrap()
   let l:wrap = &wrap
   return l:wrap == 'nowrap'?'WRAP':'wrap'
endfunction

"
" function to display state of spell
"
function! Spell()
	let l:spell = &spell
   return l:spell == 'nospell'?'SPELL':'spell'
endfunction

"
" function to display state of spell
"
"function! Limelight()
"	let l:light = &Limelight
"   return l:light == 'nospell'?'LLIGHT':'llight'
"endfunction


"
"	Configure Colour Scheme Set default colour scheme
"
colorscheme badwolf							" Set default colour scheme
set termguicolors								" Enable 24bit colours
"
" Badwolf Options
"
" Gutter darker than edit area: 0 off 1 on
let g:badwolf_darkgutter = 1 
" Tab bar compared to edit area: 0 darker 1 same 2 brighter 3 btigher still 
let g:badwolf_tabline = 0 
" Underline <a> tags in html: 0 off 1 on
let g:badwolf_html_link_underline = 1 
" highlight css tags in html: 0 off 1 on
let g:badwolf_css_props_highlight = 1


"--------------------------------------------------------------------------------------------------
"	Configure UI 
"--------------------------------------------------------------------------------------------------
"
"	Tabstops
"
set tabstop=4   	      	" Move 4 visual spaces per tab 
set softtabstop=0       	" Move 4 spaces per tab when editing
set expandtab            	" Use spaces for tabs by default
set shiftwidth=4				" ? not sure I understand this
set smarttab					" insert shiftwidth at BOL tabstop elsewhere
"
"	Appearance
"
set number              	" show line numbers by default
set showcmd             	" show command in bottom bar ? does it work
set cursorline          	" highlight current line with undeline bar
set wildmenu            	" visual autocomplete for command menu
set lazyredraw          	" redraw only when we need to.
set showmatch           	" highlight matching [{()}]

"
"	Folding
"
set foldenable          	" enable folding
set foldlevelstart=99    	" by default start with no folding
set foldnestmax=10      	" 10 nested fold max
set foldmethod=indent  	 	" fold based on indent level

"
"  Spell Checker
"
set spelllang=en_us,en_gb
set spellfile=~/.vim/spell/en.utf-8.add
hi clear SpellBad
hi clear SpellCap
hi clear SpellRare
hi clear SpellLocal
hi SpellBad   ctermfg=05 cterm=underline
hi SpellCap   ctermfg=11 cterm=underline
hi SpellRare  ctermfg=02 cterm=underline ctermbg=11
hi SpellLocal ctermfg=00 cterm=underline ctermbg=11
"
"  space open/closes folds
"
nnoremap <space> za		

"
"	Search
" 
set incsearch           	" search as characters are entered
set hlsearch            	" highlight matches
set ignorecase smartcase 	" ignore case when searching
"
" turn off search highlight
"
nnoremap <leader><space> :nohlsearch<CR>

"
"	Cursor movement 
"

"	Move down by visual rather than file line
noremap <down> g<down>		

"	Move up by visual rather than file line
noremap <up> g<up>

"--------------------------------------------------------------------------------------------------
" Setup for bufferes in tabs & tabbed editing
"--------------------------------------------------------------------------------------------------

cnoremap e<space> tabedit<space>
noremap  <silent> <f7> :tabp<cr>
noremap! <silent> <f7> <C-o>:tabp<cr>
noremap  <silent> <f8> :tabn<cr>
noremap! <silent> <f8> <C-o>:tabn<cr>

"--------------------------------------------------------------------------------------------------
" Shortcutis to edit/source this file
"--------------------------------------------------------------------------------------------------

let vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
execute 'nnoremap <leader>h :call ProfileHelp() <cr>'
execute 'nnoremap <leader>u :call UnicodeHelp() <cr>'
execute 'nnoremap <leader>a :call AnsibleHelp() <cr>'
execute 'nnoremap <leader>l :call LinuxHelp() <cr>'

":call ToggleLineNumber()<CR>

"
" Looking into having /r open the vim-profile readme in browser WIP how to
" make platform independent
"
"Open markdown files with Chrome.
"autocmd BufEnter *.md exe 'noremap <F5> :!start C:\Users\tomas\AppData\Local\Google\Chrome\Application\chrome.exe %:p<CR>'
"https://chrome.google.com/webstore/detail/markdown-preview-plus/febilkbfcbhebfnokafefeacimjdckgl/related

"--------------------------------------------------------------------------------------------------
" Configure function keys
"--------------------------------------------------------------------------------------------------

"
" Toggle Line numbers on/off
"
noremap  <silent> <f2> :set number!<cr>
noremap! <silent> <f2> <C-o>:set number!<cr>

"
" Toggle Invisible Characters on/of, first define 
" mappings for non-visible characters the the toggle
"
set listchars=space:·,nbsp:✦,eol:$,tab:»\ ,trail:~,extends:>,precedes:<
noremap  <silent> <f3> :set list!<CR>
noremap! <silent> <f3> <C-o>:set list!<CR>

"
" Toggle softtab on/off
"
noremap  <silent> <f4> :set expandtab!<CR>
noremap! <silent> <f4> <C-o>:set expandtab!<CR>

"
" Toggle wrap on/off
"
noremap  <silent> <f5> :set wrap!<CR>
noremap! <silent> <f5> <C-o>:set wrap!<CR>

"
" Toggle spelling check on off
"
noremap  <silent> <f6> :setlocal spell!<CR>
noremap! <silent> <f6> <C-o>:setlocal spell!<CR>

"
" Toggle Limelight on off
"
execute 'noremap  <silent> <f9>  :Limelight!!<CR>'
execute 'noremap! <silent> <f9> <C-o> :Limelight!!<CR>'



"--------------------------------------------------------------------------------------------------
" Configure Status line
"--------------------------------------------------------------------------------------------------


"
" Status line definition.
"
" old info section: set statusline+=%-30.40(Info:\ \[%{&fileformat}\]\[%{&fileencoding?&fileencoding:&encoding}\]%y%r%m%) 
"
set laststatus=2
set statusline=
set statusline+=%2*File:%-10.50(%t%m%r%)
set statusline+=%1*
set statusline+=%(Help=\\\h\ F2=%{Number()}\ F3=%{List()}\ F4=%{ExpandTab()}\ F5=%{Wrap()}\ F6=%{Spell()}\ F7/8=P/N%)
"set statusline+=%(Help=\\\h\ F2=%{Number()}\ F3=%{List()}\ F4=%{ExpandTab()}\ F5=%{Wrap()}\ F6=%{Spell()}\ F7/8=P/N\ %{Limelight()}%)
set statusline+=%=
"set statusline+=%-90.90(%)
set statusline+=%4*
set statusline+=%-21.21(Pos:\[%n\]\ %p%%\ %l:%c%)
set statusline+=%7.7(\ u%05.5B%)

set belloff=all


