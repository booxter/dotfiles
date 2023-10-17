plugins=(git ssh-agent)

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# prefer gnu grep from homebrew; macosx grep is very slow
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# initialize ruby env for jekyll
export PATH="/usr/local/opt/ruby@3.1/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.1.0/bin:$PATH"

# use nvim
alias vim='nvim'
export EDITOR='nvim'

# still use emacs bindings
bindkey -e

if [ -e $HOME/.zshrc.local ]; then
  . $HOME/.zshrc.local
fi
