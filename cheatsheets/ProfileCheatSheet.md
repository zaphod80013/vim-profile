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

## Spelling

| :----| :----
|z= | For the word under/after the cursor suggest correctly spelled words or alternatives.
|]s | Move to next misspelled word after the cursor.
|[s | Like "]s" but search backwards, find the misspelled  word before the cursor.
|]S | Like "]s" but only stop at bad words, not at rare words or words for another region.
|[S | Like "]S" but search backwards.
|zg | Add word under the cursor as a good word first name in 'spellfile'
|zG | Like "zg" but add the word to the internal word list
|zw | Like "zg" but mark the word as a wrong (bad) word.
|zW | Like "zw" but add the word to the internal word list
                                                        [S

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

