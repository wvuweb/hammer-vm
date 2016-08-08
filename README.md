# A Virtual Machine for Hammer

## Introduction

This project automates the setup of a development environment for working with [Hammer](https://github.com/wvuweb/hammer).

## How to install

  1. Install [VirtualBox](https://www.virtualbox.org)
  1. Install [Vagrant](http://vagrantup.com)
  1. Install [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) by running:
    * `vagrant plugin install vagrant-triggers`
  1. If you haven't made the `Sites` and `cleanslate_themes` folders, run:
    * `cd ~ && mkdir Sites && cd ~/Sites/ && mkdir cleanslate_themes`
  1. Next, we have to build the Hammer virtual machine. Building the virtual machine is easy:
    ```bash
    cd ~/Sites/ && git clone https://github.com/wvuweb/hammer-vm.git
    cd hammer-vm
    vagrant up
    ```

    * **NOTE:** The first time you run `vagrant up`, it may take 5-30 minutes to build the virtual machine. On subsequent `vagrant up`'s it will only take a few seconds.
  1. Visit [localhost:2000](http://localhost:2000) in the browser at to access your [CleanSlate](http://cleanslatecms.wvu.edu) themes.

If the build fails run `vagrant provision` until it completes.  If you have continue to have issues, open an [issue](https://github.com/wvuweb/hammer-vm/issues).

## Commands

To be ran from the `/hammer-vm/` directory
```bash
vagrant up              # Start Hammer
vagrant halt            # Stop Hammer
vagrant hammer update   # Update Hammer
vagrant status          # Is the VM running?
```

## Mac/Linux Alias

If you would like to have aliases for the above command add the following to your `.bash_profile`, `.bashrc`, or `.profile` in your user root directory.
```
alias hammer-start="cd ~/Sites/hammer-vm && vagrant up"
alias hammer-stop="cd ~/Sites/hammer-vm && vagrant halt"
alias hammer-update="cd ~/Sites/hammer-vm && vagrant hammer update"
```

### Other Notes

Truth be told, you don't actually need a `Sites` folder—we simply include it for consistency. To get Hammer working, the `hammer-vm` and `cleanslate_themes` directories must be on the same level, like so:
```
/Sites/
|_/hammer-vm/
|_/cleanslate_themes/
```
