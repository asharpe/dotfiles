# see http://www.weinschenker.name/2013-10-08/use-gpgtools-for-ssh-logins-on-mac-os-x/
export GPG_TTY=$(tty)
if [[ -f "${HOME}/.gpg-agent-info" ]]
then
	source "${HOME}/.gpg-agent-info"
	export GPG_AGENT_INFO
fi
