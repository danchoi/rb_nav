" Vim script that add ability to search and play iTunes tracks from Vim
" Maintainer:	Daniel Choi <dhchoi@gmail.com>
" License: MIT License (c) 2011 Daniel Choi

" This can be set in .vimrc
if !exists("g:RbNavPaths")
  let g:RbNavPaths = ""
  for x in ['.']
    if isdirectory(x)
      let g:RbNavPaths .= x.' '
    endif
  endfor
endif

let s:last_class_search = ""

func! RbNavClasses()
endfunc

func! RbNavMethods()
endfunc

func! s:trimString(string)
  let string = substitute(a:string, '\s\+$', '', '')
  return substitute(string, '^\s\+', '', '')
endfunc

func! s:prepare_autocomplete()
  let s:current_file = bufname('')
  leftabove split rb_nav_prompt
  setlocal textwidth=0
  setlocal buftype=nofile
  setlocal noswapfile
  setlocal modifiable
  setlocal nowrap
  resize 2
  noremap <buffer> <Esc> :close<cr>
  inoremap <buffer> <Tab> <C-x><C-u>
endfunc

" Classes

function! s:autocomplete_classes()
  call s:prepare_autocomplete()
  inoremap <buffer> <cr> <Esc>:call <SID>open_class_file()<cr>
  noremap <buffer> <cr> <Esc>:call <SID>open_class_file()<cr>
  setlocal completefunc=AutocompleteRbNavClasses
  call setline(1, "Select a class or module: ")
  call setline(2, "") " s:last_class_search)
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
      if m =~ substitute(a:base, '\*', '\\*', '')
        call add(res, m)
      endif
    endfor
    return res
  endif
endfun

func! RbNavClasses()
  let command = "grep -rn ".g:RbNavPaths." --exclude='.git/*' --include='*.rb' -e '^\\s*\\(class\\|module\\) \\+[A-Z]'  | rb_nav_classes | sort"
  let res = system(command)
  return split(res, "\n")
endfunc

" Methods

function! s:autocomplete_methods()
  call s:prepare_autocomplete()
  inoremap <buffer> <cr> <Esc>:call <SID>jump_to_method()<cr>
  noremap <buffer> <cr> <Esc>:call <SID>jump_to_method()<cr>
  setlocal completefunc=AutocompleteRbNavMethods
  call setline(1, "Select a method: ")
  call setline(2, "")
  normal G$
  call feedkeys("a\<c-x>\<c-u>\<c-p>", 't')
endfunction

function! AutocompleteRbNavMethods(findstart, base)
  if a:findstart
    let start = 0
    return start
  else
    let res = [] 
    for m in RbNavMethods()
      " why doesn't case insensitive flag work?
      if m =~ '^\c.\?' . substitute(a:base, '\*', '\\*', '')
        call add(res, m)
      endif
    endfor
    return res
  endif
endfun

func! RbNavMethods()
  let command = "grep -n '^\\s*def ' ".s:current_file." | rb_nav_methods "
  echom command
  let res = system(command)
  return split(res, "\n")
endfunc

func! s:open_class_file()
  if (getline(2) =~ '^\s*$')
    close
    return
  endif
  let selection = s:trimString(getline(2))
  close
  let query = get(split(selection, '\s\+'), 0)
  let location = get(split(selection, '\s\+'), -1)
  let path = get(split(location, ':'), 0)
  let line = get(split(location, ':'), 1)
  if filereadable(path)
    let s:last_class_search = query
    exec 'edit '.path
    exec "normal ".line."G"
    call feedkeys("z\<cr>", "t")
  else
    echo "File ".path." not found"
  endif
endfunc

func! s:jump_to_method()
  if (getline(2) =~ '^\s*$')
    close
    return
  endif
  let selection = s:trimString(getline(2))
  close
  let line = get(split(selection, '\s\+'), -1)
  exec 'normal '.line.'G'
  call feedkeys("z\<cr>", "t")
endfunc

nnoremap <Leader>N :call <SID>autocomplete_classes()<cr>
nnoremap <Leader>n :call <SID>autocomplete_methods()<cr>
