set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'flazz/vim-colorschemes'
Plugin 'tpope/vim-surround'
Plugin 'vimwiki/vimwiki'

call vundle#end()            " required
filetype plugin indent on    " required

let mapleader=" "

" Python settings
set tabstop=4 
set shiftwidth=4
set smarttab
set expandtab 
set softtabstop=4 
set autoindent

let python_highlight_all = 1
set t_Co=256
syntax on 

" Relative line number
set relativenumber
set nu

set mouse=a " Enable mouse
set termencoding=utf-8 
set t_vb= 

set wrap
set linebreak

" Disable .swp 
set nobackup
set noswapfile
set encoding=utf-8 " Default file encoding
set fileencodings=utf8,cp1251

set clipboard=unnamed
set ruler

set hidden
set visualbell t_vb= " disable vim sound

colorscheme solarized

