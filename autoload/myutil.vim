func! myutil#after() abort
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

  nnoremap <silent> j gj
  nnoremap <silent> k gk


endf
