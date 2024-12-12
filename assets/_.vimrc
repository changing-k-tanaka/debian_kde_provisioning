set nocompatible
set t_Co=256

"colorscheme
"call dein#add('crusoexia/vim-monokai')
colorscheme molokai
let s:molokai_original = 1
"let g:molokai_original = 1
"let g:rehash256 = 1
set background=dark

"terminal title bar view fix
set notitle
let &titleold=getcwd()

"#####表示設定#####
set number "行番号を表示する
"set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax enable "コードの色分け
set tabstop=2 "インデントをスペース2つ分に設定
set expandtab "タブでのインデントをスペースに
set smartindent "オートインデント
set clipboard=unnamed
set list
set listchars=eol:↲,tab:»-,trail:-,extends:»,precedes:«,nbsp:%

"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
nnoremap <ESC><ESC> :nohlsearch<CR>
set hls

"レジスタに格納しないようにする
"nnoremap x "_x
"vnoremap x "_x
nnoremap c "_c
vnoremap c "_c
nnoremap d "_d
vnoremap d "_d

"####ステータスライン#####
set laststatus=2
" set statusline=%<%f\ %m%r%h%w
" set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
" set statusline+=%=%l/%L,%c%V%8P

"###行番号#####
augroup numberwidth
  autocmd!
  autocmd BufEnter,WinEnter,BufWinEnter * let &l:numberwidth = len(line("$")) + 2
augroup END

"###ファイルタイプ別のインデント幅など####
augroup fileTypeIndent
  autocmd!
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.html.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.vimrc setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END


" dein
" Vim起動完了時にインストール
augroup PluginInstall
  autocmd!
  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

" 各プラグインをインストールするディレクトリ
let s:plugin_dir = expand('~/.vim/')
" dein.vimをインストールするディレクトリをランタイムパスへ追加
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_dir

" dein.vimがまだ入ってなければ 最初に`git clone`
if !isdirectory(s:dein_dir)
  call mkdir(s:dein_dir, 'p')
  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
endif

"dein plugin settings
if dein#load_state(s:plugin_dir)
  call dein#begin(s:plugin_dir)

  " ここからインストールするプラグインを書いていく
  call dein#add('Shougo/dein.vim')
  call dein#add('mrtazz/simplenote.vim')
  call dein#add('itchyny/lightline.vim')
  call dein#add('mattn/emmet-vim')
"  call dein#add('tomasr/molokai')
  call dein#add('scrooloose/nerdtree')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('szw/vim-tags')
  call dein#add('tpope/vim-fugitive')
  call dein#add('scrooloose/syntastic')
  call dein#add('tpope/vim-surround')
  call dein#add('bronson/vim-trailing-whitespace')
  call dein#add('thinca/vim-zenspace')
  call dein#add('kurocode25/mdforvim')
  call dein#add('kana/vim-smartinput')

"全角空白を常にハイライト
let g:zenspace#default_mode = 'on'

  " インストール後ビルドする場合
  "call dein#add('Shougo/vimproc.vim', {
  "     \ 'build': {
  "     \     'mac': 'make -f make_mac.mak',
  "     \     'linux': 'make',
  "     \     'unix': 'gmake',
  "     \    },
  "     \ })

  " 条件によって使ったり使わなかったり制御する場合
  call dein#add('Shougo/neocomplcache.vim') ", {'if' : has('lua') })
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

  let g:neocomplcache_enable_camel_case_completion = 1
  let g:neocomplcache_enable_underbar_completion = 1


  " 補完
  call dein#add('Shougo/neocomplcache-rsense.vim') ", {'autoload' : { 'insert' : 1, 'filetypes' : 'ruby' }})
  if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
  endif
  let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  "rsenseのインストールフォルダがデフォルトと異なるので設定
  let g:rsenseHome = expand("/Users/amaranthine/.rbenv/shims/rsense")
  let g:rsenseUseOmniFunc = 1

  " 環境変数RSENSE_HOMEに'/usr/local/bin/rsense'を指定しても動く
  "let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'

  " 依存関係がある場合
  call dein#add('Shougo/unite.vim')
  call dein#add('ujihisa/unite-colorscheme', {'depends' : 'Shougo/unite.vim'})
  call dein#add('basyura/unite-rails', {'depends': 'Shougo/unite.vim'})
  call dein#add('Shougo/unite-outline', {'depends': 'Shougo/unite.vim'})

  " 手動でcall dein#source('プラグイン名')して使い始める場合
  "call dein#add('Shougo/vimfiler', {'lazy' : 1})

  " 指定のファイルタイプ使う場合
  call dein#add('tpope/vim-rails', {'on_ft' : 'ruby'})
  call dein#add('tpope/vim-bundler', {'on_ft' : 'ruby'})
  call dein#add('ngmy/vim-rubocop', {'on_ft' : 'ruby'})
  call dein#add('thinca/vim-ref', {'on_ft' : 'ruby'})
  "call dein#add('thinca/vim-ref-ri', {'on_ft' : 'ruby'})
  let g:ref_refe_cmd = $HOME.'/.rbenv/shims/refe' "refeコマンドのパス
  call dein#add('tpope/vim-endwise', {'on_ft': 'ruby'})
  call dein#add('vim-scripts/ruby-matchit', {'on_ft': 'ruby'})

  call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript'})
  call dein#add('mxw/vim-jsx', {'on_ft': 'javascript'})


  " dein.vimで管理して更新だけするリポジトリ（NeoBundleFetchとおなじ）
  "call dein#add('jszakmeister/markdown2ctags', {'rtp': ''})

  " サブディレクトリを指定してdein#add()する場合
  " frozenオプションは自動で更新しない
  " 自分で開発するプラグインの管理に便利
  "call dein#local('~/src/github.com/violetyk',
  "     \ {
  "     \   'frozen' : 1,
  "     \   'depends' : [
  "     \     'kana/vim-gf-user',
  "     \     'Shougo/neosnippet.vim',
  "     \     'vim-jp/vital.vim'
  "     \   ]
  "     \ },
  "     \ [
  "     \   '*.vim',
  "     \   'neosnippet-*',
  "     \   'neocomplete-*',
  "     \   'scratch-utility'
  "     \ ])
  call dein#end()
  call dein#save_state()
endif


"emmetをtabキーで
autocmd FileType html imap <buffer><expr><tab>
    \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
    \ "\<tab>"

autocmd FileType eruby imap <buffer><expr><tab>
    \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
    \ "\<tab>"

autocmd FileType erb imap <buffer><expr><tab>
    \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
    \ "\<tab>"


"indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkgray  ctermbg=darkgray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=lightgray ctermbg=lightgray
"let g:indent_guides_auto_colors = 0
set ts=2 sw=2 et "indent guide
let g:indent_guides_guide_size = 1
"hi IndentGuidesOdd  ctermbg=black
"hi IndentGuidesEven ctermbg=darkgrey

" javascriptとJSXの2つのファイルタイプを指定する
au BufRead,BufNewFile *.jsx set filetype=javascript.jsx

"settings each filetype
filetype plugin indent on

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
" vimのすごい便利なのにあまり使われていない「タブページ」機能 - Qiita
" http://qiita.com/wadako111/items/755e753677dd72d8036d
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"lightlineのカスタマイズ
let g:lightline = {
		\ 'active': {
		\   'right': [ [ 'lineinfo' ],
		\              [ 'percent' ],
		\              [ 'fugitive', 'fileformat', 'fileencoding', 'filetype' , 'syntastic' ] ]
		\ },
		\ 'component_expand': {
		\   'syntastic': 'SyntasticStatuslineFlag',
		\ },
		\ 'component_type': {
		\   'syntastic': 'error',
		\ },
	  \	'component_function' : {
	  \		'fugitive' : 'MyFugitive',
	  \	}
   \ }
let g:syntastic_mode_map = { 'mode': 'passive' }
"augroup AutoSyntastic
"  autocmd!
"  autocmd BufWritePost *.c,*.cpp call s:syntastic()
"augroup END

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      let _ = fugitive#head()
      return strlen(_) ? ' Git:'._ : ' '
    endif
  catch
  endtry
  return ''
endfunction

"Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
"let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['ruby', 'yaml'] }
let g:syntastic_ruby_checkers = ['rubocop']

" 入力モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 保存時に自動で空白を保存
autocmd BufWritePre * :FixWhitespace

" NERDtreeを表示
"autocmd vimenter * NERDTree

" NERDTREEショートカットキーを設定
map <C-n> :NERDTreeToggle<CR>

" NERDTREE起動時にブックマークを表示
let NERDTreeShowBookmarks=1

" NERDtreeの起動時に表示する
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable  = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg) " , guibg)
  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guifg='. a:guifg
  " ' guibg='. a:guibg .
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',)
call NERDTreeHighlightFile('md',     'cyan',    'none', 'lightblue')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',)
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',)
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',)
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',)
call NERDTreeHighlightFile('html',   'blue',  'none', 'blue',)
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'lightblue',  )
call NERDTreeHighlightFile('css',    'cyan',    'none', 'lightblue',  )
call NERDTreeHighlightFile('rb',     '160',     'none', 'red')
call NERDTreeHighlightFile('js',     '2',       'none', 'lightgreen', )
call NERDTreeHighlightFile('php',    '55',      'none', 'magenta')

" 保護
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>


