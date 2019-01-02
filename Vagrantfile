bridge_net = "192.168.1."
internal_net = "192.168.4."
internal_dns = internal_net + "200"
internal_gateway = internal_net + "1"
internal_route = internal_net + "0/24"
domain = "example.com"

servers=[
  {
    :name => "labipa",
    :hostname => "labipa." + domain,
    :ip => bridge_net + "200",
    :ip_int => internal_net + "200",
    :ram => 512,
    :ssh_port => 10022,
    # :dvd => "D:\\LINUX\\rhel-server-7.0-x86_64-dvd.iso"
  },
  {
    :name => "server1",
    :hostname => "server1." + domain,
    :ip => bridge_net + "210",
    :ip_int => internal_net + "210",
    :ram => 512,
    :ssh_port => 10122
  },
  {
    :name => "server2",
    :hostname => "server2." + domain,
    :ip => bridge_net + "220",
    :ip_int => internal_net + "220",
    :ram => 512,
    :ssh_port => 10222
  }
]

Vagrant.configure(2) do |config|
    config.vbguest.auto_update = false
    config.vm.synced_folder ".", "/vagrant", disabled: true
    servers.each do |machine|
        config.vm.define machine[:name] do |node|
        # node.vm.usable_port_range = (2200..2250)
            # node.vm.network "public_network", ip: machine[:ip], bridge: 'Intel(R) Centrino(R) Wireless-N 130'
            node.vm.hostname = machine[:hostname]
            node.vm.network "private_network", ip: machine[:ip_int]
            node.vm.provision "shell",
              run: "always",
              inline: "nmcli con mod enp0s3 ipv4.ignore-auto-dns yes; nmcli con reload enp0s3"
            node.vm.provision "shell",
              run: "always",
              inline: "nmcli con mod \"System enp0s8\" ipv4.addresses \"" + machine[:ip_int] + "/24 " + internal_gateway + "\" ipv4.dns " + internal_dns
              node.vm.network "forwarded_port", guest: 22, host: machine[:ssh_port], id: "ssh"
            node.ssh.password = "vagrant"
            if (machine[:name].include? "server")
                node.vm.box = "rhel7.0"
                node.vm.network "private_network", ip: "0.0.0.0", auto_network: true
                node.vm.network "private_network", ip: "0.0.0.0", auto_network: true
            else
                node.vm.box = "rhel7.0-labipa"
            end
            node.vm.provider "virtualbox" do |vb|
                vb.customize ["modifyvm", :id, "--memory", machine[:ram]]
                vb.name = machine[:hostname]
                if (machine[:name].include? "labipa")
                    # vb.customize ["storageattach", :id, "--storagectl", "IDE", "--port", 0, "--device", 0, "--medium", "none"]
                    # vb.customize ["storageattach", :id, "--storagectl", "IDE", "--port", 0, "--device", 1, "--type", "dvddrive", "--medium", "emptydrive"]
                    # vb.customize ["storageattach", :id, "--storagectl", "IDE", "--port", 0, "--device", 0, "--type", "dvddrive", "--medium", machine[:dvd]]
                    # vb.customize ["modifyvm", :id, "--boot1", "disk"]
                    # vb.customize ["modifyvm", :id, "--boot2", "dvd"]
                end
                # if (!machine[:hdd_name].nil?)
                    # unless File.exist?(machine[:hdd_name])
                        # vb.customize ["createhd", "--filename", machine[:hdd_name], "--size", machine[:hdd_size]]
                    # end
                    # vb.customize ["storageattach", :id, "--storagectl", "SATA", "--port", 1, "--device", 0, "--type", "hdd", "--medium", machine[:hdd_name]]
                # end
                # vb.customize ["modifyvm", :id, "--snapshotfolder", "/home/Gregorio Espinal/vagrant-tests/snapshots"]
            end
        end
    end
end
