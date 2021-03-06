" ------
" Goyo
" -------

let s:save_option = {}
let g:goyo_width = 80

" s:goyo_enter() "{{{
" Disable visual candy in Goyo mode
function! s:goyo_enter()
   if has('gui_running')
      " Gui fullscreen
      set fullscreen
   elseif exists('$TMUX')
      " Hide tmux status
      silent !tmux set status off
      silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
   endif

  let s:save_option['showmode'] = &showmode
  let s:save_option['showcmd'] = &showcmd
  let s:save_option['scrolloff'] = &scrolloff

   set noshowcmd
   set scrolloff=5
   set nolist
   set nonumber norelativenumber

   if exists(":SignifyDisable")
      SignifyDisable
   endif
   if exists(":GitGutterDisable")
      GitGutterDisable
   endif
   if exists(":SignatureToggleSigns")
      SignatureToggleSigns
   endif
   if exists(":QuickScopeToggle")
      QuickScopeToggle
   endif
   if exists(":IndentGuidesDisable")
      IndentGuidesDisable
   endif

   set scl=no   " force the signcolumn to disappear

   " let g:neomake_place_signs = 0

   " save fold color &highlight['f:Folded']
   " hi Folded
   hi Folded ctermfg=DarkGray

   " Activate Limelight
   Limelight

   " TODO set styling for folds in pandoc
endfunction

" }}}
" s:goyo_leave() "{{{
" Enable visuals when leaving Goyo mode
function! s:goyo_leave()
   if has('gui_running')
      " Gui exit fullscreen
      set nofullscreen
   elseif exists('$TMUX')
      " Show tmux status
      silent !tmux set status on
      silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
   endif

  let &showmode = s:save_option['showmode']
  let &showcmd = s:save_option['showcmd']
  let &scrolloff = s:save_option['scrolloff']
   " set list
   set number relativenumber

   if exists(":SignifyEnable")
      SignifyEnable
   endif
   if exists(":GitGutterEnable")
      GitGutterEnable
   endif
   if exists(":SignatureToggleSigns")
      SignatureToggleSigns
   endif
   if exists(":QuickScopeToggle")
      QuickScopeToggle
   endif
   if exists(":IndentGuidesEnable")
      IndentGuidesEnable
   endif

   set scl=auto " return the signcolumn to the default behaviour
   " let g:neomake_place_signs = 1
   " hi Folded
   "

   " De-activate Limelight
   Limelight!

   if (&filetype == "tex")
      " get the proper Fold Line and stuff
      VimtexReload
   endif
endfunction
" }}}

" Goyo Commands {{{
augroup goyo_map
  autocmd! User GoyoEnter
  autocmd! User GoyoLeave
  autocmd  User GoyoEnter nested call <SID>goyo_enter()
  autocmd  User GoyoLeave nested call <SID>goyo_leave()
augroup END
" }}}
