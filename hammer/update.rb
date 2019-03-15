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
      with_target_vms(nil, :single_target => true) do |vm|
        vm.action(:provision)
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
