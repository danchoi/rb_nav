# RbNav

RbNav is a lightweight Vim pluging that helps you navigate the classes,
modules, and methods in your Ruby project 

[screenshots]

Advantages over the venerable `ri` command-line tool:

* write code and browse pertinent documentation in adjacent Vim windows
* search with autocompletion help
* hyperlinking lets you jump from definition to definition
* run back and forth through your jump history with CTRL-o and CTRL-i


## Prerequisites

* Ruby 1.8.6 (tested on 1.9.2)
* Vim 7.2 or higher

## Install

    gem install rb_nav

Then

    rb_nav_install

This installs the ri.vim plugin into your ~/.vim/plugin directory. 

To upgrade RbNav to a newer version, just repeat the installation procedure.
Don't forget to run `rb_nav_install` again after you download the new gem.


## Commands

For the all the commands below, the mapleader is assumed to be `,`. If it is
`\` or something else for your setup, use that instead.

### Invoking the plugin

* `,N` navigating classes and modules
* `,n` navigating methods in the current file


Press `TAB` to start autocompletion.

Use the standard Vim autocompletion commands to move up and down the match
list.

* `CTRL-p` and `CTRL-n` let you navigate the drop-down matches. Press `ENTER` to select
one.
* `CTRL-e` closes the match list and lets you continue typing
* `CTRL-u`: when the match list is active, cycles forward through the match
  list and what you've typed so far; when the match list is inactive, erases
  what you've typed.
* both `TAB` and `CTRL-x CTRL-u` reactivates autocompletion if it's gone away
* `CTRL-y` selects the highlighted match without triggering ENTER


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


