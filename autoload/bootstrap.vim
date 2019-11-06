" vim: fdm=marker

func! bootstrap#before() abort
  " setup python host in pyenv {{{
  " https://neovim.io/doc/user/provider.html#g:python_host_prog

  " build problems related to openssl
  " https://github.com/pyenv/pyenv/wiki/Common-build-problems#error-the-python-ssl-extension-was-not-compiled-missing-the-openssl-lib

  " pyenv install 3.4.4
  " pyenv virtualenv 3.4.4 py3nvim
  " pyenv activate py3nvim
  " pip install pynvim
  let g:python3_host_prog = '/home/sll/.pyenv/versions/py3nvim/bin/python'
  let g:python_host_prog  = '/home/sll/.pyenv/versions/py2nvim/bin/python'

  " }}}
  " SpaceVim Wildfire mapping
  " call SpaceVim#custom#SPC('map',  ['<Space>'], '<Plug>(wildfire-fuel)', 'select and expand to closest regon', 0)
  " call SpaceVim#custom#SPC('vmap', ['<C-Space>'], '<Plug>(wildfire-water)', 'shrink selected regon', 0)
  " call SpaceVim#custom#SPC('map',  ['x', 'w'], '<Plug>(wildfire-fuel)', 'select and expand to closest regon', 0)
  " call SpaceVim#custom#SPC('vmap', ['x', 'W'], '<Plug>(wildfire-water)', 'shrink selected regon', 0)

  " call SpaceVim#custom#SPC('nnoremap', ['x', 'a', '<Space>'], 'Tabularize / /', "align region at ' '", 1)

  " Additional Key Bindings {{{
  nnoremap ZAQ :qa!<CR>
  nnoremap ZAZ :wqa<CR>

  " call SpaceVim#custom#SPC('xmap', ['x', 'a'], '<Plug>(LiveEasyAlign)', 'align interactive', 0)
  " call SpaceVim#custom#SPC('nmap', ['x', 'a'], '<Plug>(LiveEasyAlign)', 'align interactive operator', 0)

  " call SpaceVim#custom#SPC('nnoremap', ['t', 'u'], 'UndotreeToggle', 'toggle UndoTree', 1)

  " call SpaceVim#custom#SPC('nnoremap', ['q', 'c', '<Space>'], 'call setqflist([])', "clear quickfix list", 1)

  " }}}
  " fruzzy
  " let g:fruzzy#usenative = 1
  " let g:fruzzy#sortonempty = 1 " default value
  " call denite#custom#source('_', 'matchers', ['matcher/fruzzy'])
endf

func! bootstrap#after() abort
  " <C-R> replacements ;)  "{{{
  " C-r: Easier search and replace
  xnoremap <C-r> :<C-u>call VSetSearch('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>
  function! VSetSearch(cmdtype)
    let temp = @s
    normal! gv"sy
    let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  " }}}
  " Automatically write to remote location {{{
  augroup write_remote " init the augroup
  augroup END
  command! -nargs=1 -complete=file WriteRemote
        \ au! write_remote BufWritePost <buffer> silent Nwrite <args>

  command! WriteRemoteClear au! write_remote BufWritePost <buffer>

  " }}}
  " Key mappings {{{
  nnoremap <silent> j gj
  nnoremap <silent> k gk
  vnoremap <silent> j gj
  vnoremap <silent> k gk

  " After block yank and paste, move cursor to the end of operated text and don't override register
  vnoremap y y`]
  vnoremap p "_dP`]
  nnoremap p p`]

  " Yank and paste from clipboard
  nnoremap <leader>yy "+yy

  " have x (removes single character) not go into the default registry
  nnoremap x "_x
  " Make X an operator that removes without placing text in the default registry
  " nmap X "_d
  " nmap XX "_dd
  " vmap X "_d
  " vmap x "_d

  " Don't yank to default register when changing something
  nnoremap c "xc
  xnoremap c "xc

  " Reselect last-pasted text
  nnoremap gp `[v`]

  " Fix the cw at the end of line bug default Vim has special treatment (:help cw)
  nmap cw ce
  nmap dw de

  " D deletes to the end of the line, and Y yanks to end of line
  nnoremap D d$
  nnoremap Y y$

  " Keep the cursor in place while joining lines, (Enter at cursor splits lines)
  " nnoremap J mzJ`z

  " }}}

  " ALE config {{{

"   let g:ale_linters = {
" \   'c': ['ccls', 'clangtidy'],
" \   'cpp': ['ccls', 'clangtidy']
" \}

" 'clang',
  " let g:ale_c_parse_compile_commands = 1
  " let g:ale_cpp_parse_compile_commands = 1
  " let g:ale_set_loclist = 0
  " let g:ale_set_quickfix = 1

  " }}}

  " let $RUST_BACKTRACE = 1
  " let g:LanguageClient_loggingLevel = "DEBUG"
  " let g:LanguageClient_loggingFile = "/tmp/lsp_client.log"
  " let g:LanguageClient_serverStderr = "/tmp/lsp_server.log"

  " source my full goyo config
  " let g:limelight_conceal_ctermfg="DarkGray"
  " source ~/.SpaceVim.d/goyo.vim

  set diffopt=filler,internal,vertical,iwhite,algorithm:patience

  let g:coc_enable_locationlist = 0
  set updatetime=300

  " set noautoread
  " Better display for messages
  " set cmdheight=1
endf


