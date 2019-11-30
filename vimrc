set nocompatible
syntax on
filetype plugin indent on

" タイプ途中のコマンドを画面最下行に表示
set showcmd
" 閉じ括弧が入力されたときに対応する括弧にわずかの間ジャンプする。
set showmatch
" 折りたたみ設定
"set foldmethod=syntax
set foldmethod=marker

" 検索設定
" 検索キーワードのハイライト表示
set hlsearch
set incsearch
nnoremap <Esc><Esc> :noh<CR><Esc>
set ignorecase smartcase
set wrapscan
" インデント
set smartindent

" タブ幅の指定
set softtabstop=2
set shiftwidth=2
set tabstop=2
" タブをスペースに変換しない
set expandtab
" 行数の表示
set number
" 現在行の強調表示
set cursorline
" ルーラの表示
set ruler
" コマンド行の高さ
set cmdheight=1
" statulineを表示
set laststatus=2
" タブを常に表示
set showtabline=2
" 無名レジスタの内容を*レジスタにも入れる(要するにヤンクしたらクリップボードにコピー)
set clipboard&
set clipboard^=unnamed
if has('unnamedplus')
	set clipboard^=unnamedplus
endif


" .swp, .~, .un~\ファイルの作成先
function s:mk_tmp_vim_dir()
	let l:tmp_dir = $HOME . '/tmp'
	if !isdirectory(l:tmp_dir)
		call mkdir(l:tmp_dir, 'p')
	endif
	let l:tmp_dir = l:tmp_dir . '/vim'
	if !isdirectory(l:tmp_dir)
		call mkdir(l:tmp_dir, 'p')
	endif
endfunction
call s:mk_tmp_vim_dir()
set directory=$HOME/tmp/vim
set backupdir=$HOME/tmp/vim
set undodir=$HOME/tmp/vim

" 選択時に行末まで選択は改行は含まない
vmap $ $h

" タブ操作
nnoremap <C-t>t :tabnew<CR>
nnoremap <C-t>n :tabnext<CR>
nnoremap <C-t>p :tabprevious<CR>
nnoremap <C-t>e :tabedit ./

" 独自関数群
" Open junk file.
function! s:open_junk_file()
	let l:junk_dir = $HOME . '/.junk'. strftime('/%Y/%m')
	if !isdirectory(l:junk_dir)
		call mkdir(l:junk_dir, 'p')
	endif

	let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
	if l:filename != ''
		execute 'edit ' . l:filename
	endif
endfunction
command! -nargs=0 Junk call s:open_junk_file()

function! s:cd_here()
	:cd %:p:h
	:pwd
endfunction
command! -nargs=0 CdHere call s:cd_here()

function! s:cd_pop()
	:cd -
	:pwd
endfunction
command! -nargs=0 CdPop call s:cd_pop()

command! -nargs=0 QQ :quitall

set ambiwidth=double

" java設定
" 標準クラスのハイライト表示
:let java_highlight_all=1
" デバッグ文らしきもののハイライト表示
:let java_highlight_debug=1
" 余分な空白のハイライト表示
:let java_space_errors=1
" メソッドの宣言文のハイライト表示
:let java_highlight_functions=1
function! s:set_java_setting()
	setlocal list
	setlocal listchars=tab:>_,trail:-,eol:$
	setlocal fileformat=unix
	setlocal fileencoding=utf8
	setlocal omnifunc=javacomplete#Complete

	setlocal wildignore+=*\\build\\*,*/build/*
	setlocal wildignore+=*.class " java
endfunction
autocmd FileType java call s:set_java_setting()

augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['gopls']},
      \ 'whitelist': ['go'],
      \ })
  autocmd FileType go setlocal omnifunc=lsp#complete
augroup END

function! s:set_go_setting()
	setlocal fileencoding=utf8
	setlocal fileformat=unix
endfunction
autocmd FileType go call s:set_go_setting()

if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
endif

autocmd FileType typescript setlocal completeopt-=menu
autocmd FileType typescript setlocal backupcopy=yes
autocmd FileType * setlocal backupcopy=yes

" start ctrlp setting
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
set wildignore+=*\\node_modules\\*,*/node_modules/* " for node.js
set wildignore+=*.class

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll|class|jar|war)$'
			\ }

" マルチバイト対応
let g:ctrlp_key_loop = 1
" end ctrlp setting

" bufferline
let g:bufferline_echo = 1
let g:bufferline_active_buffer_left = '['
let g:bufferline_active_buffer_right = ']'
let g:bufferline_modified = '+'
let g:bufferline_show_bufnr = 1
let g:bufferline_rotate = 1

function! s:dirvish_here()
	:Dirvish %:p:h
endfunction

command! -nargs=0 DirvishHere call s:dirvish_here()

let g:memolist_path = "$HOME/.memo"

if filereadable('private.vim')
	source private.vim
endif
