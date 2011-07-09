" Vim script that add ability to search and play iTunes tracks from Vim
" Maintainer:	Daniel Choi <dhchoi@gmail.com>
" License: MIT License (c) 2011 Daniel Choi

let g:RbNavPaths="app lib"

func! RbNavClasses()
endfunc

func! RbNavMethods()
endfunc

func! s:trimString(string)
  let string = substitute(a:string, '\s\+$', '', '')
  return substitute(string, '^\s\+', '', '')
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
        call add(res, m)
      endif
    endfor
    return res
  endif
endfun

func! RbNavClasses()
  let command = "grep -rn  '^\s*\\(class\\|module\\) ' ".g:RbNavPaths." | rb_nav_classes | sort"
  let res = system(command)
  return split(res, "\n")
endfunc

func! s:open_file()
  if (getline(2) =~ '^\s*$')
    close
    return
  endif
  let selection = s:trimString(getline(2))
  close
  let location = get(split(selection, '\s\+'), -1)
  let path = get(split(location, ':'), 0)
  let line = get(split(location, ':'), 1)
  exec 'edit '.path
  exec "normal ".line."G"
  call feedkeys("z\<cr>", "t")
endfunc

nnoremap <Leader>e :call <SID>autocomplete_classes()<cr>



