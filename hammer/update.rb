class Update < Vagrant.plugin(2, :command)

  def self.synopsis
    "updating hammer internals"
  end

  def execute
    puts "Updating Hammer..."
    `vagrant ssh -c "sudo kill -9 $(ps ax | grep '[h]ammer_server.rb' | awk '{print $1}') && cd /srv/hammer && git pull && bundle install && cd hammer && ruby hammer_server.rb --daemon 1" default`
    puts "Hammer updated!"
  end
end
