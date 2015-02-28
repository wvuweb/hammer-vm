class Update < Vagrant.plugin(2, :command)

  def self.synopsis
    "updating hammer internals"
  end

  def execute
    # puts "Updating Hammer..."
    # puts "Stopping Hammer Processes..."
    # `vagrant ssh -c "sudo kill -9 $(ps ax | grep '[h]ammer_server.rb' | awk '{print $1}')" default -- -qT`
    # puts "Pulling latest code from Github..."
    # `vagrant ssh -c " cd /srv/hammer && sudo git pull" default -- -qT`
    # puts "Running Bundle install..."
    # `vagrant ssh -c "sudo bundle install" default -- -qT`
    # puts "Restarting Hammer..."
    # `vagrant ssh -c "cd /srv/hammer/hammer && ruby hammer_server.rb --daemon 1" default  -- -qT`
    # puts "Hammer updated!"

    command1 = "sudo kill -9 $(ps ax | grep '[h]ammer_server.rb' | awk '{print $1}')"
    command2 = "cd /srv/hammer && sudo git pull"
    command3 = "cd /srv/hammer && sudo bundle install"
    command4 = "cd /srv/hammer/hammer && ruby hammer_server.rb --daemon 1"

    with_target_vms(nil, :single_target => true) do |vm|
      safe_puts("Stopping Hammer Processes...")
      vm.action(:ssh_run, :ssh_run_command => command1, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Pulling latest code from GitHub...")
      vm.action(:ssh_run, :ssh_run_command => command2, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Running Bundle Install...")
      vm.action(:ssh_run, :ssh_run_command => command3, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Restarting Hammer...")
      vm.action(:ssh_run, :ssh_run_command => command4, ssh_opts: {extra_args: ["-qT"]})
      safe_puts("Finished Upgrade!")
      return 0
    end



  end
end
