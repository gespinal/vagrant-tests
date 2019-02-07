for i in `vagrant global-status | grep -E 'server?|labipa' | awk '{print$2}'`; do vagrant snapshot save $i $i.`date +%Y%m%d%H`; done
