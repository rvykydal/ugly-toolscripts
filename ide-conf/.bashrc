# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

function parse_git_branch {
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1='[\u@\h \w$(parse_git_branch)]$ '

EDITOR=/usr/bin/vim

alias svirsh="virsh -c qemu:///session"

complete -f -X '!*.@(rvm)' rv-virt-install
complete -f -X '!*.@(rvm)' rv-virt-ssh

#_rv-virt-logs()
#{
#    ls *.rvm
#}
#complete -F _rv-virt-logs rv-virt-logs.sh
