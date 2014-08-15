# PATHS
# ==============================================================================
if [ -r "${HOME}/.zsh/zprofile.paths" \
     -a X"${_ZPROFILE_PATHS_LOADED}" = X"" \
]; then
    source "${HOME}/.zsh/zprofile.paths"
fi
# ==============================================================================

# STANDARD TWEAKS
# ==============================================================================
# Disable core dumps by default.
limit coredumpsize 0

# Set restrictive umask.
umask 022

# Watch for user logins, but not mine.
watch=( notme )

# Disable messaging.
mesg n
# ==============================================================================

# COMMON ENV VARIABLES
# ==============================================================================
# Export convenience vars.
export OS="`uname -s`"

# Set language and LC_*.
if [ X"${OS}" = X"SunOS" ]; then
    export LC_ALL="C"
    export LANG="C"
else
    export LANG="en_US.UTF-8"
    export LC_COLLATE="en_US.UTF-8"
    export LC_CTYPE="en_US.UTF-8"
    export LC_MESSAGES="en_US.UTF-8"
    export LC_MONETARY="en_US.UTF-8"
    export LC_NUMERIC="en_US.UTF-8"
    export LC_TIME="en_US.UTF-8"
    export LC_ALL="en_US.UTF-8"
fi

# Set history options.
export HISTSIZE=5000
export HISTFILE="$HOME/.zhistory.${HOST}"
export SAVEHIST=5000

# Allocate additional memory to SBT.
export SBT_OPTS=-XX:MaxPermSize=256m

# Set pager.
which less >/dev/null 2>&1
if [ $? -eq 0 ]; then
    if [ X"${OS}" != X"OpenBSD" ]; then
        export LESS="EiMXJ"
    fi
    export PAGER="less"
    alias more="less"
else
    export PAGER="more"
fi

# Use vim for all the things!
which vim >/dev/null 2>&1
if [ $? -eq 0 ]; then
    export EDITOR=vim
    export VISUAL=vim
    export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
        vim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
        -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
        -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""
fi
# ==============================================================================

# COLORS (SEE ALSO: ZSTYLE BELOW)
# ==============================================================================
# Use colored terminal by default.
export COLORTERM=yes

# Load ZSH color constants.
autoload colors
colors

# Colorize 'time' output.
export TIMEFMT="${fg_bold[blue]}${terminfo[smul]}%J${terminfo[rmul]}${terminfo[sgr0]}
${fg_bold[green]}Time:${terminfo[sgr0]} ${fg[green]}%*E real, %*U user, %*S system  %P cpu${terminfo[sgr0]}
${fg_bold[yellow]}Faults:${terminfo[sgr0]} ${fg[yellow]}%F major, %R minor${terminfo[sgr0]}
${fg_bold[cyan]}Context Switches:${terminfo[sgr0]} ${fg[cyan]}%w voluntary, %c involuntary${terminfo[sgr0]}"

# Colorize user login notification output.
export WATCHFMT="${fg_bold[yellow]}*${terminfo[sgr0]} [%W %T]  ${fg_bold[green]}%n${terminfo[sgr0]} ${fg_bold[magenta]}(%l)${terminfo[sgr0]} %a from ${fg_bold[blue]}%m${terminfo[sgr0]}"

# Colorize completion lists using ZLS_COLORS.
zmodload -i zsh/complist
autoload -U compinit && compinit
# ==============================================================================

# ZSTYLE
# ==============================================================================
# Set completion options.
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Use completion caching.
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zcache-$HOST

# Expand partial paths.
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Include non-hidden directories in globbed file completions for some commands.
zstyle ':completion::complete:*' '\' # '

# Use menu selection for pid completion.
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# tag-order 'globbed-files directories' all-files
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Do not complete backup files as executables.
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Separate matches into groups.
zstyle ':completion:*:matches' group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format "${fg[blue]}---- %B%d%b${terminfo[sgr0]}"
zstyle ':completion:*' format "${fg[yellow]}completing %B%d%b${terminfo[sgr0]}"

# Messages/warnings format.
zstyle ':completion:*:messages' format "${fg[green]}%B%U---- %d%u%b${terminfo[sgr0]}"
zstyle ':completion:*:warnings' format "${fg[red]}%B%U---- no match for: %d%u%b${terminfo[sgr0]}"

# Describe options in full.
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# Simulate spider's old abbrev-expand 3.0.5 patch.
zstyle ':completion:*:history-words' stop verbose
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false

# Use 'ls' colors for ZSH completion colors.
zstyle ':completion:*' list-colors "${ZLS_COLORS}"
zstyle ':completion:*:*:kill:*' list-colors '=%*=01;31'

# Use separate sections in manpage completion.
zstyle ':completion:*:manuals'       separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections   true

# Ignore file extensions when completing vim filenames.
zstyle ':completion:*:*:vim:*:*files' ignored-patterns \
    '*?.class' '*?.pdf' '*\~' '*?.o' '*?.pyc'
zstyle ':completion:*:*:v:*:*files' ignored-patterns \
    '*?.class' '*?.pdf' '*\~' '*?.o' '*?.pyc'
# ----------------------------------------------------------------------
