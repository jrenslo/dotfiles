#! /bin/zsh

# "default" simple header, has to do with completion?
autoload -U compinit promptinit
compinit -C
promptinit
setopt complete_in_word  #allows for completion in words e.g. cd /A/M/G

## case-insensitive (all),partial-word and then substring completion
# found at http://www.rlazo.org/2010/11/18/zsh-case-insensitive-completion/
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' \
    'r:|[._-]=* r:|=*' 'l:|=* r:|=*'


# Set prompt (% as escape character)
# %{%F{color}%} %{%f%} - colors text in between
# %n                   - name
# %d                   - directory from home
# %*                   - time as HH:mm:ss
# %D                   - date as YY-MM-DD
autoload -U colors && colors
#PROMPT="%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m %{$fg[blue]%}%* %{$fg[red]%}%~ %{$reset_color%}%# "
PS1="%{%F{15}%}[%n@%m %1d] $ %{%f%}"
RPROMPT="[%* %W]"

# Zsh options

setopt dvorak
HISTFILE=~/.zsh-histfile  #cache the command history here
HISTSIZE=10000
SAVEHIST=10000

# Aliases
alias .="cd ."
alias ..="cd .."
alias lsal="ls -alG"
# Default to colored ls
alias ls="pwd;ls -G"
alias mv='nocorrect mv -i'       # no spelling correction on mv
alias cp='nocorrect cp -i'       # no spelling correction on cp
alias rm='rm -i'
alias mkdir='nocorrect mkdir' # no spelling correction on mkdir
alias diff='diff -bBr'        # ignore whitespace.  ignore blank lines.
                              # recursively compare directories
alias cl=clear

# Altering $PATH
PATH=$PATH:/Applications/MotionGenesis

# By Balaji S. Srinivasan (balajis@stanford.edu)
# Bash eternal history
# --------------------
# This snippet allows infinite recording of every command you've ever
# entered on the machine, without using a large HISTFILESIZE variable,
# and keeps track if you have multiple screens and ssh sessions into the
# same machine. It is adapted from:
# http://www.debian-administration.org/articles/543.
#
# The way it works is that after each command is executed and
# before a prompt is displayed, a line with the last command (and
# some metadata) is appended to ~/.bash_eternal_history.
#
# This file is a tab-delimited, timestamped file, with the following
# columns:
#
# 1) user
# 2) hostname
# 3) screen window (in case you are using GNU screen)
# 4) date/time
# 5) current working directory (to see where a command was executed)
# 6) the last command you executed
#
# The only minor bug: if you include a literal newline or tab (e.g. with
# awk -F"\t"), then that will be included verbatime. It is possible to
# define a bash function which escapes the string before writing it; if you
# have a fix for that which doesn't slow the command down, please submit
# a patch or pull request.
postcmd() { eval "$PROMPT_COMMAND" } # use zsh's precommand hook to emulate bash
PROMPT_COMMAND='echo -e $$\\t$USER\\t$HOSTNAME\\t`date +%D%t%T%t%Y%t%s`\\t$PWD\\t"$(fc -ln -1)" >> ~/.bash_eternal_history'

