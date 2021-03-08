# Vim-Profile Repository Overview

## Initial Setup and Installing a Git Repository Based Profile 

### Create the Git Repository
Create repository 'vim-profile' on Github and clone it to the local file system. This avoids having to create a new
repository on github from the cli.
```
	=> git clone https://github.com/zaphod80013/vim-profile.git
```

To create from the CLI, you still need to create an empty repository on github for this to work
```
   => mkdir vim-profile
   => cd vim-profile
   => git init
   => touch README.md
   => git add -A
   => git commit -a -m "Initial commit to set up repository"
   => git remote add origin git@github.com:zaphod80013/vim-profile.git
   => git push -u origin master
```

Navigate to the repository on the local file system to continue setup, this involves initializing submodule support and creating the basic file structure. 

Create directory structure for native plugin support. Any directory under pack will be scanned at startup and plugins in
it's start sub-directory loaded automatically. Plugin in the corresponding opt directory can be loaded on demand using the 
packadd command. Naming at the level below pack is user defined, one approach is to use the github/gitlab username of the
3rd-party plugin, another is a functional division such as themes, languages etc. I've elected to group plugins by language
with a separate folder for globally applicable plugins.

```
   => cd vim-profile
   => git submodule init
   => mkdir -p pack/{bash,python,docker,gobal}/{opt,start}
```

### Installing the repository on a new machine

There are two basic approaches, firstly you can create the ~/.vim (or appropriate directory for your system) by cloning 
the repository as follows:
```
=> git clone --recursive https://github.com/zaphod80013/vim-profile.git ~/.vim`
```
or alternatively you can clone the repo and link the corresponding profile directory to it.
```
   => git clone --recursive https://github.com/zaphod80013/vim-profile.git 
   => ln -s ~/<path to repo>/vim-profile ~/.vim
```

The later is probably more approriate on a machine where you intend to do profile development.

### Git Submodule Management

All the following commands should be executed from the root of the git repository.

#### Checking out a repository with submodules
```
	=> git clone --recursive https://github.com/zaphod80013/vim-profile.git
```

#### Adding a plugin from a git repository as a submodlue 
```
   => git submodule add https://github.com/\*/????.git pack/\*/start/?????
   => git commit -m "Add plugin ????? as a submodule."
   => git push
```

#### Removing a plugin installed as a submodule
```
   => git submodule deinit pack/\*/start/?????
   => git rm -r pack/\*/start/?????
   => rm -r .git/modules/pack/\*/start/?????
   => git commit -am "....."
   => git push
```

#### Updating a plugin installed as a submodule
```
   => cd ~/.vim/pack/\*/start/?????
   => git pull origin master
   => git commit -am "....."
   => git push
```

Alternatively if you wish to review the repository commits first do the following (is there a step missing after fetch?)
```
   => cd ~/.vim/pack/\*/start/?????
   => git fetch origin master
   => git merge
   => git commit -am "....."   
   => git push
```

#### Updating all plugins at once
```
   => git submodule foreach git pull origin master
   => git commit -am "....."
   => git push
```

## Installed Plugins

These are the plugins I use, kudos to their respective authors

1.   https://github.com/sjl/badwolf.git pack/global/start/badwolf
1.   https://github.com/ekalinin/Dockerfile.vim.git pack/docker/start/Dockerfile.vim
1.   https://github.com/chrisbra/unicode.vim.git pack/global/start/unicode.vim


## Profile Documentation
### Funcion Key Assignments

| Key  |Description| 
|:----:|:----------------
| F1   |Help
| F2   | Toggle Line numbers             
| F3   | Toggle Listchars (visible space, non-breaking space., tab, end of line) 
| F4   | Toggle Softtabs  
| F5   | Toggle Line wrap 
| F6   | Toggle Spell-checker    
| F7   | Previous tab (in tabbed editing mode) 
| F8   | Next tab 

### Leader Commands
Leader Character /

| Sequence  |Description| 
|:----:|:----------------
|/<space>| Turn off Highlighting (i.e. from search)	
|/ev|Edit vimrc file
|/sv|Source vimrc file
|/u|Open Unicode CheatSheet in new Tab

### Normal Mode Commands

| Sequence  |Description| 
|:----:|:----------------
|<space>|Toggle folding
| &#x2191;| Move up physical rather than logical line
| &#x2193;| Move down physical rather than logical line

### Command Mode (:) Commands

| Sequence  |Description| 
|:----:|:----------------
|e<space>|:tabedit

### Insert Mode Commands

| Sequence  |Description| 
|:----:|:----------------
|^v u*nnnn*|Enter 4 digit Unicode Character
|^v U*nnnnnnnn*|Enter 8 digit Unicode Character
 


