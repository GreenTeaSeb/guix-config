alias ls='eza -lF'
alias lt='ls --tree'
#alias cp='cpv'
alias vim='nvim'
alias docker-compose='podman compose'
alias docker='podman'
alias db='~/Documents/go.jetify.com/devbox/dist/devbox'

export PATH=/home/sveb/Documents/go.jetify.com/devbox/dist:/home/sveb/.nix-profile/bin:$PATH

source /home/sveb/src/antidote/.antidote/antidote.zsh
antidote load  ~/.config/zsh/.zsh_plugins.txt 

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

eval "$(zoxide init zsh)"
autoload -Uz compinit && compinit
