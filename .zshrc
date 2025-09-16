# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git web-search z fast-syntax-highlighting  zsh-autocomplete zsh-autosuggestions )
# plugins+=(zsh-nvm you-should-use fzf-tab)  # some other useful plugins
# fast-syntax-highlighting is fast alternative of zsh-syntax-highlighting

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/."


# alias eza https://eza.rocks/
alias ls='eza -l'
alias py="python3"
alias python="python3"
alias sz="source ~/.zshrc && echo '~/.zshrc sourced'"
alias ip="ifconfig -a | egrep -A 7 '^en0' | grep inet | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | head -n 1"
alias myip="curl -s -w '\n' http://api.ipify.org"
alias path='echo; tr ":" "\n" <<< "$PATH"; echo;'       # Pretty print PATH
alias psg='ps aux | grep -v grep | grep -i -e VSZ'      # Pretty print processes"

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'

function json() {
  echo "$1" | jq .
}

function jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}


function fcd() {
  local dir
  dir=$(find "${1:-.}" \( -type d -path '*/.*' -prune \) -o \( -type d -print \) 2> /dev/null | fzf --preview 'tree -C {} | head -n 100' +m) && cd "$dir"
}


function fzkill() {
  local pid
  pid=$(ps -ef | fzf --preview 'echo {}' | awk '{print $2}') && kill -9 "$pid"
}


# Simple calculator
function calc() {
        local result=""
        result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
        #                       └─ default (when `--mathlib` is used) is 20
        #
        if [[ "$result" == *.* ]]; then
                # improve the output for decimal numbers
                printf "$result" |
                sed -e 's/^\./0./'        `# add "0" for cases like ".5"` \
                    -e 's/^-\./-0./'      `# add "0" for cases like "-.5"`\
                    -e 's/0*$//;s/\.$//'   # remove trailing zeros
        else
                printf "$result"
        fi
        printf "\n"
}


# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}

# Create a data URL from a file
function dataurl() {
        local mimeType=$(file -b --mime-type "$1")
        if [[ $mimeType == text/* ]]; then
                mimeType="${mimeType};charset=utf-8"
        fi
        echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# GitHub URL for current repo.
function gurl() {
  local remotename="${@:-origin}"
  local remote="$(git remote -v | awk '/^'"$remotename"'.*\(push\)$/ {print $2}')"
  [[ "$remote" ]] || return
  local user_repo="$(echo "$remote" | perl -pe 's/.*://;s/\.git$//')"
  echo "https://github.com/$user_repo"
}

export LESS="${LESS} --mouse"   # Enable mouse support in less/bat

# Don’t clear the screen after quitting a manual page.
# export MANPAGER='less -X';

# set vim as default editor
# export EDITOR='vim';
# export VISUAL='vim'


# bat configs
alias cat='bat -pp'     # bat --style=plain --paging=never
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"