install
======

for windows
```
git clone --recursive https://github.com/saiki/vimfiles.git $HOME/vimfiles
```
for linux
```
git clone --recursive https://github.com/saiki/vimfiles.git $HOME/.vim
```
update submodule

```
git submodule foreach git pull origin master
```

add submodule

```
~/.vim> git submodule add <url> pack/pack/start/<module_name>
```
