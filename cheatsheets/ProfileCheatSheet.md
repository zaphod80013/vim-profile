# Vim Profile Cheatsheet

## Leader Commands

Leader character is \ (backslash)
:------ | :------
\ev     |Edit vimrc
\sv     |Reload vimrc
\a      |Ansible Cheatsheet (toggle)
\h      |Vim Profile cheatsheet (toggle)
\l      |Linux Cheatsheet (toggle)
\u      |Unicode Character Cheatsheet (toggle)
\<space>|Cancel Search Highlight

# format for filetype detect in ftdetect

   filename: xxx.vim
   Content:   au BufNewFile,BufRead *.pn set filetype=potion 
