Vagrant boxes (virtualbox provider):

For servers1 & server2:

	vagrant init gespinal/rhel7.0 \
		--box-version 1.0
	vagrant up

For LABIPA:

	vagrant init gespinal/rhel7.0.labipa \
		--box-version 1.0
	vagrant up

REPO:

  	ftp://labipa.example.com/pub/repo

KRB5 Files:

 	ftp://labipa.example.com/pub/krb5.conf
 	ftp://labipa.example.com/pub/server1.keytab
  	ftp://labipa.example.com/pub/server2.keytab
