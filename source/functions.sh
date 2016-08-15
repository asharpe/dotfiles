function install_ssh_keys() {
	[ -z "$1" ] && {
		echo "Need a host to connect to"
		return 1
	}

# TODO regex for IP address
#	getent hosts "$1" || {
#		echo "Cannot resolve $1 via DNS"
#		return 2
#	}

#	cat ~/work/code/svn/ops/sysadmin/ssh_keys/squiz_bris/* | \
	cat ~/.ssh/*.pub | \
		ssh "$1" 'mkdir .ssh >&/dev/null; [ -f .ssh/authorized_keys ] && mv .ssh/authorized_keys .ssh/authorized_keys.$(date +%s); cat > .ssh/authorized_keys; chmod 700 .ssh; chmod 600 .ssh/authorized_keys'
}
export -f install_ssh_keys


function wiid() {
	ssh squiz-cru01.hba.squiz.net.au "su - wiid -c '~/whyisitdown/whyisitdown $1 "$2"'"
}
export -f wiid


function ssh() {
	local args=()
	local disable_control_path=0
	local port_forward_option_re="^-[DLR]"

	for arg
	do
		[[ $arg =~ $port_forward_option_re ]] && disable_control_path=1
		args+=("$arg")
	done

	if ((disable_control_path))
	then
		echo "disabling control master..."
		args=(
			-o
			"ControlPath none"
			"${args[@]}"
		)
	fi

	command ssh "${args[@]}"
}
export -f ssh


# we want colour and paging in svn diff commands
svn () {
	# bail if the user didnt specify which subversion command to invoke
	if (( $# < 1 )) || ! [[ -t 1 ]]
	then
		command svn "$@"
		return
	fi
 
	local sub_cmd=$1
	local pager=cat
	shift

	# abbreviations stolen from 'svn help'
	case $sub_cmd in
		st*|di*|log|blame|praise|ann*|h*|?) pager='less -Rf'
	esac
 
	#intercept svn diff commands
	if [[ $sub_cmd == diff ]]
	then
 
		# colorize the diff
		# remove stupid ^M dos line endings
		# page it if there's more one screen
		command svn diff "$@" | colordiff | sed -e "s/\\\r//g"
 
	# add some color to svn status output and page if needed:
	# M = blue
	# A = green
	# D/!/~ = red
	# C = magenta
	#
	#note that C and M can be preceded by whitespace - see $svn help status
	elif [[ $sub_cmd =~ ^(status|st)$ ]]
	then
		command svn status "$@" | sed -e 's/^\(\([A-Z]\s\+\(+\s\+\)\?\)\?C .*\)$/\[1;35m\1[0m/' \
				-e 's/^\(\s*M.*\)$/\[1;34m\1[0m/' \
				-e 's/^\(A.*\)$/\[1;32m\1[0m/' \
				-e 's/^\(\(D\|!\|~\).*\)$/\[1;31m\1[0m/'
 
	# page some stuff I often end up paging manually
#	elif [[ $sub_cmd =~ ^(blame|help|h|cat)$ ]]
#	then
#		command svn $sub_cmd "$@"
 
	# colorize and page svn log
	# rearrange the date field from:
	#	 2010-10-08 21:19:24 +1300 (Fri, 08 Oct 2010)
	# to:
	#	 2010-10-08 21:19 (Fri, +1300)
	elif [[ $sub_cmd == log ]]
	then
		command svn log "$@" | sed -e 's/^\(.*\)|\(.*\)| \(.*\) \(.*\):[0-9]\{2\} \(.*\) (\(...\).*) |\(.*\)$/\[1;32m\1[0m|\[1;34m\2[0m| \[1;35m\3 \4 (\6, \5)[0m |\7/'

	#let svn handle it as normal
	else
		command svn "$sub_cmd" "$@"

	# TODO we don't want to page the update command
	fi | $pager
}

netstat() {
	if [[ "$1" = -tlpn ]]
	then
		netstat -anf inet | awk '$1 ~ /tcp/ && $NF == "LISTEN" { count = split($4, bits, "."); command = "lsof -nP -i:" bits[count] "| awk \"NR>1 && /LISTEN/ {print \\$2}\""; command | getline pid; $(NF+1) = pid; print}' | column -t
	else
		command netstat "$@"
	fi
}
export -f netstat

