alias ls='eza -lF'
alias lt='ls --tree'
#alias cp='cpv'
alias vim='nvim'
eval "$(starship init zsh)"

fpath=(/gnu/store/66ayi4nplg0h4gx7y3kc0j6l0jz7c6g3-zsh-completions-0.34.0 $fpath)
#source /home/sveb/Additional/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /gnu/store/hgypd2yavd2gyv302iz1xl8lv5fbxi1q-zsh-autosuggestions-0.7.0/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /gnu/store/cs2k6ipi49ia89gdpb96ik397vv0whif-zsh-syntax-highlighting-0.7.1/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export PATH=/home/sveb/.nix-profile/bin:$PATH
