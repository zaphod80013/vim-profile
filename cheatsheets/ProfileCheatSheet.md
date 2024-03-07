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

## Status Bar

Feature toggles UPPERCASE = feature turned off lowecase = feature turned on


# format for filetype detect in ftdetect

### See [this](https://learnvimscriptthehardway.stevelosh.com/chapters/44.html)


   filename: xxx.vim
   Content:  

   au BufNewFile,BufRead *.pn set filetype=potion 

   .... Filetype specific commands go here, examples

   syntax keyword potionKeyword loop times to while
   syntax keyword potionKeyword if elsif else
   syntax keyword potionKeyword class return

   highlight link potionKeyword Keyword
