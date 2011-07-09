" Vim script that add ability to search and play iTunes tracks from Vim
" Maintainer:	Daniel Choi <dhchoi@gmail.com>
" License: MIT License (c) 2011 Daniel Choi

let g:RbNavPaths="lib"

func! RbNavClasses()
endfunc

func! RbNavMethods()
endfunc

func! s:prepare_autocomplete()
  leftabove split rb_nav_prompt
  setlocal textwidth=0
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal modifiable
  setlocal nowrap
  resize 2
  inoremap <buffer> <cr> <Esc>:call <SID>open_file()<cr>
  noremap <buffer> <cr> <Esc>:call <SID>open_file()<cr>
  noremap <buffer> <Esc> :close<cr>
  inoremap <buffer> <Tab> <C-x><C-u>
endfunc

function! s:autocomplete_classes()
  call s:prepare_autocomplete()
  setlocal completefunc=AutocompleteRbNavClasses
  call setline(1, "Select a class or method")
  call setline(2, "")
  normal G$
  call feedkeys("a\<c-x>\<c-u>\<c-p>", 't')
endfunction

function! AutocompleteRbNavClasses(findstart, base)
  if a:findstart
    let start = 0
    return start
  else
    let res = [] 
    for m in RbNavClasses()
      " why doesn't case insensitive flag work?
      if m =~ '^\c.\?' . substitute(a:base, '\*', '\\*', '')
        let parts = split(m, '\s\+')
        if len(parts) > 1 
          call add(res, {'word': parts[0], 'menu': parts[1]})
        else
          call add(res, m)
        endif
      endif
    endfor
    return res
  endif
endfun

func! RbNavClasses()
  let command = "grep -rn  '^\s*\\(class\\|module\\) ' lib/  | rb_nav_classes "
  let res = system(command)
  return split(res, "\n")
endfunc

func! s:open_file()
  echom "open_file"
endfunc

nnoremap <Leader>e :call <SID>autocomplete_classes()<cr>



