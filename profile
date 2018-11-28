export CHARSET=UTF-8
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PAGER=less
export PS1='\h:\w\$ '
umask 022

for script in /etc/profile.d/*.sh ; do
        if [ -r $script ] ; then
                . $script
        fi
done

# custom config

export PS1='\u@\h \w # '

alias ll='ls -la'
alias screendr='/usr/bin/screen -DR'
alias vi='/usr/bin/vim'
alias vimdiff='/usr/bin/vimdiff -O '

# shorten kubectl
function kub () {
  kubectl $@
}
export -f kub

function k () {
  kubectl $@
}
export -f k

source <(kubectl completion bash)

# add completion
complete -o default -F __start_kubectl k
complete -o default -F __start_kubectl kub

