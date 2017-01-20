set nocompatible
syntax on
filetype plugin indent on

" タイプ途中のコマンドを画面最下行に表示
set showcmd
" 閉じ括弧が入力されたときに対応する括弧にわずかの間ジャンプする。
set showmatch
set cmdheight=2
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
set noexpandtab
" 行数の表示
set number
" 現在行の強調表示
set cursorline
" ルーラの表示
set ruler
" コマンド行の高さ
set cmdheight=2
" statulineを表示
set laststatus=2
" 無名レジスタの内容を*レジスタにも入れる(要するにヤンクしたらクリップボードにコピー)
set clipboard+=unnamed

" .swp, .~, .un~\ファイルの作成先
set directory=$HOME/tmp/vim
set backupdir=$HOME/tmp/vim
set undodir=$HOME/tmp/vim

" 選択時に行末まで選択は改行は含まない
vmap $ $h

" タブ操作
nnoremap <C-t>t :tabnew<CR>
nnoremap <C-t>n :tabnext<CR>
nnoremap <C-t>p :tabprevious<CR>

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
endfunction
command! -nargs=0 CdPop call s:cd_pop()

function! s:dirvish_here()
	:Dirvish %:p:h
endfunction

command! -nargs=0 QQ :quitall

set ambiwidth=double
" colorschme
colorscheme gruvbox

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
	setlocal tabstop=8
	setlocal shiftwidth=4
	setlocal softtabstop=4
	setlocal list
	setlocal listchars=tab:>_,trail:-,eol:$
	setlocal fileformat=unix
	setlocal fileencoding=utf8
	setlocal omnifunc=javacomplete#Complete

	setlocal wildignore+=*\\build\\*,*/build/*
	setlocal wildignore+=*.class " java
endfunction
autocmd FileType java call s:set_java_setting()

if has("autocmd") && exists("+omnifunc")
	autocmd Filetype *
				\	if &omnifunc == "" |
				\		setlocal omnifunc=syntaxcomplete#Complete |
				\	endif
endif

" 近いほうを使う
noremap ; :
noremap : ;

function! s:settings()
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

	command! -nargs=0 DirvishHere call s:dirvish_here()

	let g:memolist_path = "$HOME/.memo"

endfunction

autocmd VimEnter * nested call s:settings()


