# RbNav

RbNav is a lightweight Vim plugin that helps you navigate the classes,
modules, and methods in your Ruby project 

[screenshots]

Benefits:

* navigate the classes and modules in your Ruby projects with less typing
* jump to methods on current page more quickly
* symbol-centric approach to navigation might suit you better than the file-centric approach

Please check out my related Vim plugin
[ri.vim](http://danielchoi.com/software/ri_vim.html) for Ruby
documentation-browsing features.

## Prerequisites

* Ruby 1.9 or higher (tested on 1.9.2)
* Vim 7.2 or higher
* GNU grep 2.6.3 or higher (check your version with `grep -V`)

## Install

    gem install rb_nav

Then

    rb_nav_install

This installs the rb_nav.vim plugin into your ~/.vim/plugin directory. 

To upgrade RbNav to a newer version, just repeat the installation procedure.
Don't forget to run `rb_nav_install` again after you download the new gem.


## Commands

For the all the commands below, the mapleader is assumed to be `,`. If it is
`\` or something else for your setup, use that instead.

### Invoking the plugin

* `,N` navigate the classes and modules in your project
* `,n` navigate the methods in the current file

To change these keymappings, edit the two lines at the end of
`~/.vim/plugin/rb_nav.vim`.

* `CTRL-p` and `CTRL-n` let you navigate the drop-down matches
* `<ENTER>` selects an item
* `CTRL-e` closes the match list and lets you continue typing
* `CTRL-u`: when the match list is active, cycles forward through the match
  list and what you've typed so far; when the match list is inactive, erases
  what you've typed.
* both `TAB` and `CTRL-x CTRL-u` reactivates autocompletion if it's gone away
* `CTRL-y` selects the highlighted match without triggering ENTER




### The search path

By default RbNav searches files using these `grep` command flags:

    let g:RbNavPaths = " . --exclude-dir='\.git' --exclude-dir='vendor'  \
    --exclude-dir='db' --include='*.rb' "

You can override these flags by reassigning `g:RbNavPaths` to something else in
a `.vimrc` files in your project's root directory.


## Bug reports and feature requests

Please submit them here:

* <https://github.com/danchoi/rb_nav/issues>


## About the developer

My name is Daniel Choi. I specialize in Ruby, Rails, MySQL, PostgreSQL, and iOS
development. I am based in Cambridge, Massachusetts, USA.

* Twitter: [@danchoi][twitter] 
* Personal Email: dhchoi@gmail.com  
* My Homepage: <http://danielchoi.com/software>

[twitter]:http://twitter.com/#!/danchoi


