install
======

for windows
```
$ git clone --recursive https://github.com/saiki/vimfiles.git $HOME/vimfiles
```
for linux
```
$ git clone --recursive https://github.com/saiki/vimfiles.git $HOME/.vim
```
update submodule

```
~/.vim> git submodule foreach git pull origin master
```

add submodule

```
~/.vim> git submodule add <url> pack/pack/start/<module_name>
```

remove submodule

```
~/.vim> git submodule deinit path/to/submodule
~/.vim> git rm path/to/submodule
```
