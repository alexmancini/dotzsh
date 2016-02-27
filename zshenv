# PATHS
# ==============================================================================
if [ -r "${HOME}/.zsh/zprofile.paths" -a X"${_ZPROFILE_PATHS_LOADED}" = X"" ]; then
    source "${HOME}/.zsh/zprofile.paths"
elif [ -r "/etc/zsh/zprofile.paths" -a X"${_ZPROFILE_PATHS_LOADED}" = X"" ]; then
    source "${HOME}/.zsh/zprofile.paths"
fi
# ==============================================================================


# INIT
# ==============================================================================
# Export convenience vars.
export OS="`uname -s`"
# ==============================================================================


# OH MY ZSH
# ==============================================================================
# Path to your oh-my-zsh configuration.
if [ -d "$HOME/.zsh/oh-my-zsh" ]; then
    ZSH="$HOME/.zsh/oh-my-zsh"
elif [ -d "/etc/zsh/oh-my-zsh" ]; then
    ZSH="/etc/zsh/oh-my-zsh"
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to enable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(               \
    adb                 \
    autopep8            \
    bower               \
    brew                \
    brew-cask           \
    bundler             \
    capistrano          \
    coffee              \
    colored-man         \
    docker              \
    docker-compose      \
    encode64            \
    fabric              \
    gem                 \
    gitfast             \
    git-flow-avh        \
    golang              \
    gradle              \
    grails              \
    grunt               \
    gulp                \
    laravel5            \
    lein                \
    mvn                 \
    nmap                \
    node                \
    npm                 \
    osx                 \
    pep8                \
    pip                 \
    pylint              \
    python              \
    rake                \
    rails               \
    ruby                \
    sbt                 \
    scala               \
    sudo                \
    supervisor          \
    symfony2            \
    vagrant             \
    vi-mode             \
    virtualenv          \
    yum                 \
)

source $ZSH/oh-my-zsh.sh
# ==============================================================================


# ALIASES
# ==============================================================================
if [ -r ~/.zsh/zalias ]; then
    source ~/.zsh/zalias
fi

if [ -r ~/.zsh/zalias.local ]; then
    source ~/.zsh/zalias.local
fi
# ==============================================================================


# PROMPT
# ==============================================================================
# TODO: Convert this to a proper ZSH theme and submit pull request.
if [ -r /etc/zsh/zprompt ]; then
    source /etc/zsh/zprompt
fi

if [ -r ~/.zsh/zprompt ]; then
    source ~/.zsh/zprompt
fi
# ==============================================================================


# MISC.
# ==============================================================================
# IRC settings.
if [ -r ~/.ircnet ]; then
    source ~/.ircnet
fi
# ==============================================================================


# KEYBINDINGS
# ==============================================================================
if [ -r ~/.zsh/zbindings ]; then
    source ~/.zsh/zbindings
fi

if [ -r ~/.zsh/zbindings.local ]; then
    source ~/.zsh/zbindings.local
fi
# ==============================================================================
