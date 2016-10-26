# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 1.7.2"

# Check for plugins
unless Vagrant.has_plugin?("vagrant-triggers")
  raise 'vagrant-triggers is not installed!'
end

unless Vagrant.has_plugin?("vagrant-env")
  raise 'vagrant-env is not installed!'
end

Vagrant.configure('2') do |config|
  config.env.enable
  config.vm.box      = 'ubuntu/trusty32'
  config.vm.hostname = 'hammer-vm'

  config.vm.network :forwarded_port, guest: 2000, host: ENV['HOST_PORT'] || 2000

  cleanslate_themes_dir = ENV['CLEANSLATE_THEMES'] || '../cleanslate_themes'
  config.vm.synced_folder cleanslate_themes_dir, "/srv/cleanslate_themes"
  # config.vm.synced_folder "../cleanslate_themes", "/srv/cleanslate_themes"

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true

  config.trigger.after [:up, :provision], stdout: true, stderr: true do
    info "Starting Hammer..."
    run_remote "cd /srv/hammer && git config --global http.sslverify false"
    run_remote "cd /srv/hammer/hammer && ruby hammer_server.rb --daemon 1"
  end

  config.trigger.before [:halt], stdout: true, stderr: true do
    info "Stopping Hammer..."
    run_remote "sudo kill -9 $(ps ax | grep '[h]ammer_server.rb' | awk '{print $1}')"
  end
end
