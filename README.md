Vagrant boxes (virtualbox provider):

For servers & server2:

	vagrant init gespinal/rhel7.0 \
		--box-version 1.0
	vagrant up

For LABIPA:

	vagrant init gespinal/rhel7.0.labipa \
		--box-version 1.0
	vagrant up
