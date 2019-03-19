# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_version ">= 2.1.0"

# Check for plugins

# Vagrant trigger plugin is no longer needed as of vagrant 2.1.0
# https://www.vagrantup.com/docs/triggers/
# unless Vagrant.has_plugin?("vagrant-triggers")
#   raise 'vagrant-triggers is not installed!'
# end

unless Vagrant.has_plugin?("vagrant-env")
  raise 'vagrant-env is not installed!'
end

Vagrant.configure('2') do |config|
  config.env.enable
  config.vm.box      = 'ubuntu/xenial64'
  config.vm.hostname = 'hammer-vm'

  host_port = ENV['HOST_PORT'] || 2000

  config.vm.network :forwarded_port, guest: 8080, host: host_port

  cleanslate_themes_dir = ENV['CLEANSLATE_THEMES'] || '../cleanslate_themes'
  config.vm.synced_folder cleanslate_themes_dir, "/srv/cleanslate_themes"

  dev_environment = ENV['DEV_ENVIRONMENT'] || false
  hammer_version =  ENV['HAMMER_VERSION'] || false

  config.vm.provision :shell, path: 'bootstrap.sh', keep_color: true, privileged: false, env: {HAMMER_VERSION: hammer_version, DEV_ENVIRONMENT: dev_environment}

  config.trigger.before [:provision, :halt, :reload] do |trigger|
    trigger.info = "Stopping Hammer..."
    trigger.run_remote  = { inline: "sudo kill -9 $(ps ax | grep '[h]ammer_server.rb' | awk '{print $1}')" }
  end

  config.trigger.after [:up, :provision, :reload] do |trigger|
    trigger.info = "Starting Hammer..."
    trigger.run_remote = { privileged: false, inline: "cd /srv/hammer/hammer && ruby -W0 hammer_server.rb --daemon 1 --host #{host_port}" }
  end

end
