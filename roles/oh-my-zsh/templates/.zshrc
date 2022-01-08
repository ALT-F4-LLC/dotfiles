# PYENV
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYENV_SHIMS=$(pyenv root)/shims
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_PATH="$PYENV_ROOT/bin"

# DOTFILES
export DOTFILES_PATH="$HOME/.dotfiles/bin"

# PATH
export PATH="$PYENV_SHIMS:$PYENV_PATH:$DOTFILES_PATH:/usr/local/sbin:$PATH"

# OH-MY-ZSH
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting zsh-z)

source $ZSH/oh-my-zsh.sh

# DEFAULTS
export ARCHFLAGS="-arch x86_64"
export EDITOR='nvim'

# PIP
export PIP_REQUIRE_VIRTUALENV=true

# NNN
n () {
  if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

  nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f "$NNN_TMPFILE" > /dev/null
  fi
}

# ALIASES
alias cat='bat --paging=never --theme="base16"'
alias ll='n -Hde'
alias ssh='TERM="xterm-256color" ssh'

# The next line sources a private environment file if it exists
if [ -f "$HOME/.zsh_public" ]; then . "$HOME/.zsh_public"; fi
if [ -f "$HOME/.zsh_private" ]; then . "$HOME/.zsh_private"; fi

# TODO : cleanup scripting below

# ITERM (MACOS ONLY)
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
test -e /usr/share/nvm/init-nvm.sh && source /usr/share/nvm/init-nvm.sh

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Development/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Development/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Development/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Development/google-cloud-sdk/completion.zsh.inc"; fi
