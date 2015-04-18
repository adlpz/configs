# oh-my-zsh
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

CUSTOM_ZSH=$HOME/.zsh
source $CUSTOM_ZSH/*

# Banner
_print_zsh_banner

# Custom prompt
PROMPT=$'%{$fg_bold[blue]%}$(parse_git_dirty)$(git_prompt_info)%{$fg_bold[blue]%}%{$fg[white]%}%c%{$fg_bold[cyan]%} %#%{$reset_color%} '
INITIAL_RPROMPT=$'[%{\e[0;31m%}%n%{\e[0;37m%}@%{\e[0;32m%}%m%{\e[0m%}]'
RPROMPT=$INITIAL_RPROMPT

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# Path
export PATH="/Users/adria/tools/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/mysql-5.5.28-osx10.6-x86_64/bin:/usr/local/Cellar/php54/5.4.9/bin"

# $EDITOR
export EDITOR=$(which vim)

# vim mode
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
export KEYTIMEOUT=1
function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% N]% %{$reset_color%}"
    RPROMPT="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $INITIAL_RPROMPT"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# Homebrew
export HOMEBREW_GITHUB_API_TOKEN="6d172fc6b90506f5e375654e21aa7482e685f46b"

# Vagrant
vagrant_up_and_ssh() {
    vagrant status | sed -n 3p | grep -q running > /dev/null
    if [ $? -eq 1 ]; then
        vagrant up
    fi
    vagrant ssh
}

# Aliases
alias ls='ls -G'
alias l='ls -l'
alias v="vagrant"
alias vssh="vagrant_up_and_ssh"

# History
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob

# keys
bindkey "\e[3~" delete-char

# No duplicates when searching history
setopt HIST_FIND_NO_DUPS

# completion.zsh: Directives for the Z-Shell completion system.
# P.C. Shyamshankar <sykora@lucentbeing.com>

autoload -Uz compinit && compinit

zstyle ':completion:*' list-colors "${LS_COLORS}" # Complete with same colors as ls.

# Fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _expand _complete _correct _approximate # Completion modifiers.
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' max-errors 1 # Be lenient to 1 errors.

# And if you want the number of errors allowed by _approximate to increase with the length of what you have typed so far:
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Ignore completion functions for commands you don?~@~Yt have:
zstyle ':completion:*:functions' ignored-patterns '_*'

# Ignore the current directory in completions
zstyle ':completion:*' ignore-parents pwd

# Use a completion cache
zstyle ':completion:*' use-cache true
zstyle ':completion:*' cache-path /.zsh/cache

# Completing process IDs with menu selection:
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# If you end up using a directory as argument, this will remove the trailing slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true

# Sudo completion
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
