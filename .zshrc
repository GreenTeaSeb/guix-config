alias ls='eza -lF'
alias lt='ls --tree'
#alias cp='cpv'
alias vim='nvim'
alias docker-compose='podman compose'
alias docker='podman'

export PATH=/home/sveb/.nix-profile/bin:$PATH

source /home/sveb/src/antidote/.antidote/antidote.zsh
antidote load

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

eval "$(zoxide init zsh)"
