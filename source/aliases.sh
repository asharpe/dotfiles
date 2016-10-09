alias opssvn='cd $HOME/work/code/svn/ops'
alias mount_work='mount -t nfs -o locallocks wdmycloud.local:/nfs/work $HOME/work'
alias mount_downloads='mount -t nfs -o locallocks wdmycloud.local:/nfs/Downloads $HOME/Downloads/shared'
alias cdgit='cd $HOME/work/code/git'
#alias work_mount='mount -t nfs wdmycloud.local:/nfs/work $HOME/work'


# see http://superuser.com/questions/182477/how-to-disable-notify-on-screen-d-r#answer-220420 for -q option
#alias rrd='screen -S rrd -xRR -q'
#alias vbox='screen -S vbox -xRR -q'
alias vbox='tmux has-session -t vbox && tmux attach-session -t vbox || tmux new-session -s vbox'
#alias imap='screen -S imap -xRR -q'
#alias imap='screen -xRR -q -S imap sh /home/asharpe/bin/imapfilter.sh'

# to make SQ_CONF_ROOT_URLS into wiki urls
# just enter the URLS followed by EOF
alias wiki_urls='cat <<EOF | sed -re "s^(.*)^|| http://\1 ||^"'


# work on an mq repository
# see http://mercurial.selenic.com/wiki/MqTutorial#Versioning_our_patch_set
alias mq='hg -R $(hg root)/.hg/patches'


alias vso='curl -vso /dev/null'
# the 'c' means 'bust cache'
alias vsoc='vso -H "Cache-Control: no-cache"'

# http-replicator for RPM package downloading
# there should be an appropriate firewall rule to work with this, ie
# -A PREROUTING -p tcp -m physdev --physdev-in vboxnet1 -m tcp --dport 80 -j REDIRECT --to-ports 8080
#alias web-proxy='sh /Volumes/passport-111/cache/http-replicator.sh'
#alias web-proxy='screen -xRR -q -S web-proxy sh /Volumes/passport-111/cache/http-replicator.sh'

# view SAR graphs
alias ksar='java -jar /home/asharpe/tmp/ksar/trunk/kSar/dist/kSar.jar'

alias svnx='svn --ignore-externals'

# teamviewer
alias teamviewer='schroot -p -c natty-i386 teamviewer'
#alias music='screen -xRR -q -S music vlc playlist.pls'

# saving two characters... really!?
#alias ssht='ssh -t'

# see https://opswiki.squiz.net/ncallahan
alias showip='curl http://ipecho.net/plain; echo'

# I'm doing this too many times a day
alias opssvn='cd ~/work/code/svn/ops'
alias labssvn='cd ~/work/code/svn/labs'


alias repoproxy='tmux has-session -t repoproxy >&/dev/null && tmux attach-session -t repoproxy || tmux new-session -s repoproxy "cd ~/work/code/git/repoproxy; ./repoproxy.js"'


# according to https://opswiki.squiz.net/Policies/Password_Guidelines#GeneralPasswordGuidelines
alias pwgen='pwgen -1 -c -n -y 12'

#alias hibernate='sudo rootsh -- pm-hibernate'
#alias suspend='sudo rootsh -- pm-suspend'

#alias netbeans="$HOME/apps/netbeans-7.3.1/bin/netbeans"

alias cgoban='/usr/lib/jvm/java-6-sun/jre/bin/java -Xmx150m -Dapple.awt.textantialiasing=on -Xbootclasspath/a:/usr/lib/jvm/java-6-sun-1.6.0.30/jre/lib/javaws.jar:/usr/lib/jvm/java-6-sun-1.6.0.30/jre/lib/deploy.jar:/usr/lib/jvm/java-6-sun-1.6.0.30/jre/lib/plugin.jar -classpath /usr/lib/jvm/java-6-sun-1.6.0.30/jre/lib/deploy.jar -Djnlpx.vmargs="-Xmx150m -Dapple.awt.textantialiasing=on" -Djnlpx.jvm=/usr/lib/jvm/java-7-oracle-1.7.0.45/jre/bin/java -Djnlpx.splashport=55998 -Djnlpx.home=/usr/lib/jvm/java-6-sun-1.6.0.30/jre/bin -Djnlpx.remove=false -Djnlpx.offline=false -Djnlpx.relaunch=true -Djnlpx.heapsize=-1,157286400 -Djava.security.policy=file:/usr/lib/jvm/java-6-sun-1.6.0.30/jre/lib/security/javaws.policy -DtrustProxy=true -Xverify:remote -Dsun.awt.warmup=true com.sun.javaws.Main -secure /home/asharpe/.java/deployment/cache/6.0/54/21086f76-424c919b'

# this was for a USB dongle of some sort (from the Brisbane office)
#alias internet="sudo usb_modeswitch -v 12d1 -p 1446 -I -c 12d1\:1446"

alias puppet='tmux new-session -A -t puppet'

alias ldapsearch_squiz='ldapsearch -x -y <(awk '\''$1 == "machine" && $2 == "gitlab.squiz.net" {printf "%s", $NF}'\'' ~/.netrc)'
alias ldapsearch_client='ldapsearch -x -y <(awk '\''$1 == "machine" && $2 == "gitlab.squiz.net" {printf "%s", $NF}'\'' ~/.netrc) -b dc=clients,dc=net'
