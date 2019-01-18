
let g:python3_host_prog = '/home/sll/.pyenv/versions/py3nvim/bin/python'
let g:python_host_prog  = '/home/sll/.pyenv/versions/py2nvim/bin/python'

" Start an external command with a single bang
nnoremap ! :!

" Zoom / Restore window {{{
nnoremap <C-w>z :ZoomToggle<CR>
command! ZoomToggle call s:ZoomToggle()
function! s:ZoomToggle()
   if exists('t:zoomed') && t:zoomed > -1
      execute t:zoom_winrestcmd
      let t:zoomed = -1
   else
      let t:zoom_winrestcmd = winrestcmd()
      resize
      vertical resize
      let t:zoomed = bufnr('%')
   endif
endfunction

" }}}
