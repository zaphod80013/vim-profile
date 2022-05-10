"--------------------------------------------------------------------------------------------------
"	Enable Vim Features
"--------------------------------------------------------------------------------------------------

let g:vimdir = fnamemodify(resolve(expand('<sfile>:p')), ':h')   " Save path to vim profile
"
" Alternative way to get path to vim profile at runtime in a vim script. 
" l: is local scope g: is global scope
"
" let l:vimdir = fnamemodify(resolve(expand('$MYVIMRC:p')), ':h')
"

" ALE linter options
"
" specified the linter for javascript:             let g:ale_linters = { 'javascript': ['eslint'], ....}
" only use the specified linters in ale_linters:   let g:ale_linters_explicit = 1
" turn off highlighting:                           let g:ale_set_highlights = 0
" map keys to navigate errors:                     nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"                                                  nmap <silent> <C-j> <Plug>(ale_next_wrap)
" Other:                                           let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"                                                  let g:ale_sign_error = '✘'
"                                                  let g:ale_sign_warning = '⚠'
"                                                  let g:ale_lint_on_text_changed = 'never'
" Yaml requires:         pip3 install yamllint. 
" Override rules:        edit ~/.config/yamllint/config
"
"                        extends: relaxed
"
"                        rules:
"                          line-length: disable
"
"


set nocompatible								" Turn off vi compatability
set encoding=utf-8							" set default encoding to UTF-8
scriptencoding utf-8							" Assume this script is utf-8 encoded

"--------------------------------------------------------------------------------------------------
"	Colour Management
"--------------------------------------------------------------------------------------------------
"
" Create colours for the status line
"
" Warning autocmd is additive and will create duplicates, using an augroup allows us to redefine 
" rather than add. The 'autocmd!' is used to clear the group before adding, thus avoiding 
" duplicates. 
"
augroup MyColors
    autocmd!
    autocmd ColorScheme * highlight User1 ctermbg=04 ctermfg=15 cterm=NONE
                      \ | highlight User2 ctermbg=02 ctermfg=00 cterm=NONE
                      \ | highlight User3 ctermbg=01 ctermfg=07 cterm=NONE
                      \ | highlight User4 ctermbg=05 ctermfg=07 cterm=NONE
augroup END

"--------------------------------------------------------------------------------------------------
"	File Type Management
"--------------------------------------------------------------------------------------------------

filetype on                         " Enable file type recognition
filetype indent on					" load type specific indent files from .../indent/<>.vim
filetype plugin on                  " load type specific operations from .../plugin/<>.vim
syntax enable                       " load type specific syntax rules from .../syntax/<>.vim

"--------------------------------------------------------------------------------------------------
" Custom Leader Functions
"--------------------------------------------------------------------------------------------------

"
" Display Ansible help \a  (toggle \a again to close)
"
function! AnsibleHelp()
    if expand('%:t') == 'AnsibleCheatSheet.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . g:vimdir . '/cheatsheets/AnsibleCheatSheet.md'        
        echon ''
    endif    
endfunction

"
" Display Profile help \h  (toggle \h again to close) 
"
function! ProfileHelp()
    if expand('%:t') == 'ProfileCheatSheet.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . g:vimdir . '/cheatsheets/ProfileCheatSheet.md'        
        echon ''
    endif    
endfunction

"
" Display Linux help \l  (toggle \l again to close) 
"
function! LinuxHelp()
    if expand('%:t') == 'LinuxCheatSheet.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . g:vimdir . '/cheatsheets/LinuxCheatSheet.md'        
        echon ''
    endif    
endfunction

"
" Display Unicode help \u  (toggle \u again to close) 
"
function! UnicodeHelp()
    if expand('%:t') == 'UnicodeCharacters.md'
        execute ':bd!'
        echon ''
    els    
        execute ':tabedit ' . g:vimdir . '/cheatsheets/UnicodeCharacters.md'        
        echon ''
    endif    
endfunction

"--------------------------------------------------------------------------------------------------
" Leader Commands
"--------------------------------------------------------------------------------------------------

nnoremap <leader>ev :tabedit $MYVIMRC<cr>
"
" Reload vimrc
"
nnoremap <leader>sv :source $MYVIMRC<cr>
"
" turn off search highlight
"
nnoremap <leader><space> :nohlsearch<CR>               
execute 'nnoremap <leader>a :call AnsibleHelp() <cr>'
execute 'nnoremap <leader>h :call ProfileHelp() <cr>'
execute 'nnoremap <leader>u :call UnicodeHelp() <cr>'
execute 'nnoremap <leader>l :call LinuxHelp() <cr>'


"--------------------------------------------------------------------------------------------------
" Custom Status Line Functions
"--------------------------------------------------------------------------------------------------

"
" Function to display state of number setting (lower case is on)
"
function! Number()
   let l:number = &number
   return l:number == 'nonumber'?'NUM':'num'
endfunction

"
" Function to display state of visible whitespace setting (lower case is visible)
"
function! List()
   let l:list = &list
   return l:list == 'nonlist'?'VIS':'vis'
endfunction

"
" Function to display state of expandtab setting (lower case is spaces, upper is \t)
"
function! ExpandTab()
   let l:expand = &expandtab
   return l:expand == 'noexpandtab'?'TAB':'tab'
endfunction

"
" Function to display state of wrap  (lower case ai wrapped)
"
function! Wrap()
   let l:wrap = &wrap
   return l:wrap == 'nowrap'?'WRAP':'wrap'
endfunction

"
" function to display state of spell (lower case is on)
"
function! Spell()
	let l:spell = &spell
   return l:spell == 'nospell'?'SPELL':'spell'
endfunction

"
" function to display state of LimeLight (lowercase is on )
"
function! Limelight()
   return !exists('#limelight')?'LLIGHT':'llight'
endfunction
"
" function to run python source from buffer.
"
function! Option()
   return &filetype == 'python'?'F10=exec':'' 
endfunction


"--------------------------------------------------------------------------------------------------
" Editor Theme Configuration
"--------------------------------------------------------------------------------------------------

colorscheme badwolf			    				      " Set default colour scheme
set termguicolors						         		" Enable 24bit colours
let g:badwolf_darkgutter = 1                    " Gutter darker than edit area: 0 off 1 on
let g:badwolf_tabline = 0                       " Tab bar compared to edit area: 0) darker 1) same 
                                                " 2) brighter 3) btigher still 
let g:badwolf_html_link_underline = 1           " Underline <a> tags in html: 0 off 1 on
let g:badwolf_css_props_highlight = 1           " Highlight css tags in html: 0 off 1 on


"--------------------------------------------------------------------------------------------------
"	Configure UI 
"--------------------------------------------------------------------------------------------------
"
"	Tabstops
"
set tabstop=3   	      	" Move 3 visual spaces per tab 
set softtabstop=0       	" Move 3 spaces per tab when editing
set expandtab            	" Use spaces for tabs by default
set shiftwidth=3			   " ? not sure I understand this
set smarttab				   " insert shiftwidth at BOL tabstop elsewhere
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
" Python Specific options
"--------------------------------------------------------------------------------------------------

augroup Python
   autocmd BufNewFile,BufRead *.py set filetype=python
   autocmd FileType python map <buffer> <F10> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
   autocmd FileType python imap <buffer> <F10> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
   autocmd BufNewFile,BufRead *.py set tabstop=4   	      
   autocmd BufNewFile,BufRead *.py set shiftwidth=4	
augroup END

"--------------------------------------------------------------------------------------------------
" Markdown specific options
"--------------------------------------------------------------------------------------------------

augroup Markdown
   autocmd!
   autocmd BufNewFile,BufRead *.md set filetype=markdown
   autocmd FileType markdown set cursorline
   autocmd FileType markdown set conceallevel=2
   autocmd FileType markdown setlocal spell spelllang=en_us
augroup END

"--------------------------------------------------------------------------------------------------
" Configure Status line
"--------------------------------------------------------------------------------------------------

set laststatus=2
set statusline=
set statusline+=%2*File:%-10.50(%t%m%r%)
set statusline+=%1*
set statusline+=%(Help=\\\h\ F2=%{Number()}\ F3=%{List()}\ F4=%{ExpandTab()}\ F5=%{Wrap()}\ F6=%{Spell()}\ F7/8=P/N\ %)
set statusline+=%(F9=%{Limelight()}\ %{Option()}%)
set statusline+=%=
set statusline+=%4*
set statusline+=%-21.21(Pos:\[%n\]\ %p%%\ %l:%c%)
set statusline+=%7.7(\ u%05.5B%)

set belloff=all


