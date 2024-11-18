export PATH=/opt/homebrew/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""

fpath+=/opt/homebrew/share/zsh/site-functions

autoload -U promptinit; promptinit
prompt pure

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  vi-mode
)

source $ZSH/oh-my-zsh.sh

# User configuration
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias vim="nvim"

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

source $HOME/.rvm/scripts/rvm

export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/platform-tools":$PATH

VI_MODE_SET_CURSOR=true

if [ -d "/opt/homebrew/opt/ruby/bin" ]; then
  export PATH=/opt/homebrew/opt/ruby/bin:$PATH
  export PATH=`gem environment gemdir`/bin:$PATH
fi

export PATH=/Applications/Barrier.app/Contents/MacOS/:$PATH
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
export PATH="$(yarn global bin):$PATH"


[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/Users/juliangomezsibecas/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"
