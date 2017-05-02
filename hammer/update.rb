require 'optparse'

module Hammer
  class Update < Vagrant.plugin(2, :command)

    def self.synopsis
      "updates the hammer server internals"
    end

    def initialize(argv, env)
      super

      @main_args, @sub_command, @sub_args = split_main_and_subcommand(argv)
    end

    def execute
      if @main_args.include?("-h") || @main_args.include?("--help")
        # Print the help for all the sub-commands.
        return help
      end

      command1 = "sudo kill -9 $(ps ax | grep '[h]ammer_server.rb' | awk '{print $1}')"
      command2 = "cd /srv/hammer && sudo git pull"
      command3 = "cd /srv/hammer && bundle install"
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

    def help
      help = OptionParser.new do |h|
        h.banner = "Usage: vagrant hammer update"
        h.separator ""
        h.separator "    # VM must be running"
        h.separator "    # #{Update.synopsis}"
        h.separator ""
        h.separator "Running this command will stop the Hammer server"
        h.separator "and pull the latest code from GitHub.  Then restart"
        h.separator "the Hammer server."
      end

      @env.ui.info(help, :prefix => false)
    end
  end
end
