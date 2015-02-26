# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure('2') do |config|
  config.vm.box      = 'ubuntu/trusty32'
  config.vm.hostname = 'hammer-vm'

  config.vm.network :forwarded_port, guest: 2000, host: 2000

  config.vm.synced_folder "../cleanslate_themes", "/srv/cleanslate_themes"

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true
end
