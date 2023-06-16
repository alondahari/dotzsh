# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH:$HOME/.cargo/bin
export PATH=$PATH:~/Library/Python/2.7/bin
NPM_PACKAGES="${HOME}/.npm-packages"

export PATH="$NPM_PACKAGES/bin:$PATH"
export EDITOR="nvim"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="geoffgarside"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias pass1="eval $(op signin uptech)"
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"
alias cd..="cd .."
alias zshrefresh="source ~/.zshrc"
alias rollback="rails db:rollback"
alias rgen="rails generate"
alias rmigrate="rails db:migrate"
alias ssh-util="ssh -i ~/.ssh/elevation-utility.pem  ec2-user@ec2-34-211-151-20.us-west-2.compute.amazonaws.com"
alias "hd"="git push heroku master && notify --title Heroku --message App successfully deployed!"
alias tgl="~/toggldesktop/TogglDesktop.sh"
alias pnv="git add -A && git commit -m'ran pre-push' && git push --no-verify"
alias pp="yarn pre-push"
alias killrails='kill -9 "$(less tmp/pids/server.pid)"'
alias st="git checkout staging"
alias co="git checkout"
alias gc="git add . && git commit"
alias llc="cd ~/loan-gurus/customer-portal"
alias llt="cd ~/loan-gurus/terraform"
alias llk="cd ~/loan-gurus/kubernetes"
alias lla="cd ~/loan-gurus/customer-portal-api"
alias lls="cd ~/loan-gurus/services"
alias lll="cd ~/loan-gurus/lambdas"
alias llsf="cd ~/loan-gurus/salesforce-service"
alias llp="cd ~/loan-gurus/partner-portal"
alias llsc="cd ~/loan-gurus/static-configs" 
alias llcc="cd ~/loan-gurus/coach-console"
alias llu="cd ~/loan-gurus/utils"
alias uuid="uuidgen"
alias clipboard="cb"
alias gca="git commit -a"
alias gpl="gps ls"
alias gprr="gps rr"
alias gpi="gps int"
alias gpr="gps rebase"
alias gpp="gps pull"

getDBSecret () {
  case $1 in
    dev)
      DOMAIN=loangurusdev
      ;;
    stage)
      DOMAIN=loangurusstage
      ;;
    prod)
      DOMAIN=uqual
      ;;
  esac
 
  # get pem from 1Password
  VAULT_GITHUB_TOKEN=$(op item get "github-token" --format json | jq '.fields[0].value' | sed "s/\"//g")
  VAULT_ENDPOINT="https://vault.$DOMAIN.com" 
  VAULT_TOKEN=$(curl -s -X "POST" "$VAULT_ENDPOINT/v1/auth/github/login" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "token": "'$VAULT_GITHUB_TOKEN'"
  }' | jq '.auth.client_token' | sed "s/\"//g")
  SECRET=$(
    curl -s "$VAULT_ENDPOINT/v1/secret/data/creds" \
    -H "X-Vault-Token: $VAULT_TOKEN" | jq '.data.data.SERVICES_SECRET' | sed "s/\"//g" 
  )

  echo $SECRET
}

jwtlocal () {
        jwt encode --exp='1y' --secret="BiOw12w9cdZjn7RaSHUCQidK9/1Z2NA6yzn8DDsjSEEsBg83c6SZmY2cQbGhW6K5D/VP9gn8388RLjDMailp54x4+LUN9JytUHU+jDwb+e9w+k6pq0NrEimleetT+TJRzMW0KwpxxzX09dwfCQJw9/H00YxU8TiJm6qE42rzUaz79FX1z5L9lwAN6IrGOD9MG1gL6WKr1+8dnK68CUiJVETDUl7RKB7+xwfCa/X4daeAFhhhhvM62nf6c6ybaZAOQn6XGNeukO1lIgoA8hZXK+HHJc3/DuKfJwJQ5++874bf9Hro3xCWcy8DGq1Wo/Y/bJX5M8zVmm6bN7lV6zOLWQ==" '{ "sub": "'"$1"'", "role": "agent", "custom:contact_id": "'"$2"'"}' | pbcopy
}

# usage: `jwtgen <dev|stage|prod> <user_id> <contact_id> <UQUAL|NCC>
jwtgen() {
        SECRET=$(getDBSecret $1)

echo '{ "sub": "'"$2"'", "role": "services", "custom:contact_id": "'"$3"'", "custom:sf_org": "'"$4"'"}'
        jwt encode --exp='1y' --secret="$SECRET" '{ "sub": "'"$2"'", "role": "services", "custom:contact_id": "'"$3"'", "custom:sf_org": "'"$4"'"}' | pbcopy
}

# added by travis gem
[ ! -s /Users/alondahari/.travis/travis.sh ] || source /Users/alondahari/.travis/travis.sh

# eval "$(starship init zsh)"
# eval "$(rbenv init -)"
