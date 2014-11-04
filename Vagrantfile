# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$vagrant_update = <<SCRIPT
  sudo apt-get -y update
  sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
  sudo apt-get -y upgrade puppet
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "puppet3box"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "app", "/app"
  config.vm.synced_folder "app/RestAPI", '/opt/www/RestAPI'
  
  config.librarian_puppet.puppetfile_dir = 'ops'

  if ENV['DEBUG']
    aptDebug = ''
  else
    aptDebug = '-qq'
  end

  config.vm.provision "shell", inline: $vagrant_update


  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "ops/puppet/manifests"
    puppet.module_path    = "ops/puppet/modules"
    # puppet.manifest_file  = "_nodes/dev.pp"

    # If you're experiencing problems with the virtual environment
    # add  next line and re-run (halt&up) vagrant
    if ENV['DEBUG']
      puppetDebug = '--verbose --debug'
    else
      puppetDebug = ''
    end

    puppet.options = "--environment dev #{puppetDebug}"
  end
end
