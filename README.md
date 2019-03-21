# A Virtual Machine for Hammer

## Introduction

This project automates the setup of a development environment for working with [Hammer](https://github.com/wvuweb/hammer).

## How to install

  1. Install [VirtualBox](https://www.virtualbox.org)
  1. Install [Vagrant](http://vagrantup.com)
  1. **STEP REMOVED** ~~Install [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) by running:~~
      * ~~`vagrant plugin install vagrant-triggers`~~
      * this plugin is no longer needed, if previously installed you will get a warning to remove it.
      * `vagrant plugin uninstall vagrant-triggers`
      * then you may have to run a plugin repair
      * `vagrant plugin repair`
  1. Install [Vagrant ENV](https://github.com/gosuri/vagrant-env) by running:
      * `vagrant plugin install vagrant-env`
  1. If you haven't made the `Sites` and `cleanslate_themes` folders, run:
      * `cd ~ && mkdir Sites && cd ~/Sites/ && mkdir cleanslate_themes`
  1. *Optional Step:* Custom cleanslate_themes directory location:
      1. Create a file named `.env` in the root directory of your `hammer-vm` install
      1. Add following line with path to directory:
          * `export CLEANSLATE_THEMES=/full/path/to/cleanslate_themes`
          * **Not yet tested on Windows**
  1. Next, we have to build the Hammer virtual machine.
      ```cd ~/Sites/ && git clone https://github.com/wvuweb/hammer-vm.git && cd hammer-vm && vagrant up```
      * **NOTE:** The first time you run `vagrant up`, it may take 5-30 minutes to build the virtual machine. On subsequent `vagrant up`'s it will only take a few seconds.

  1. Visit [localhost:2000](http://localhost:2000) in the browser at to access your [CleanSlate](http://cleanslatecms.wvu.edu) themes.

If the build fails run `vagrant provision` until it completes.  If you have continue to have issues, [open an issue](https://github.com/wvuweb/hammer-vm/issues).

## Commands

To be ran from the `/hammer-vm/` directory
```bash
vagrant up              # Start Hammer
vagrant halt            # Stop Hammer
vagrant hammer update   # Update Hammer
vagrant status          # Is the VM running?
vagrant destroy         # Destroys the VM
```

## Mac/Linux Alias

If you would like to have aliases for the above command add the following to your `.bash_profile`, `.bashrc`, or `.profile` in your user root directory.
```
alias hammer-start="cd ~/Sites/hammer-vm && vagrant up"
alias hammer-stop="cd ~/Sites/hammer-vm && vagrant halt"
alias hammer-update="cd ~/Sites/hammer-vm && vagrant hammer update"
```

### Other Notes

Truth be told, you don't actually need a `Sites` folder—we simply suggest it for consistency. To get Hammer working, the `hammer-vm` and `cleanslate_themes` directories must be on the same level, unless you have overridden the `hammer-vm` directory using a `.env` file.
```
/Sites/
|_/hammer-vm/
|_/cleanslate_themes/
```

### ENV Overrides

You can override the following configurations with a `.env` file in the root of your `hammer-vm` directory
```
CLEANSLATE_THEMES=/full/path/to/cleanslate_themes       # default: ~/Sites/cleanslate_themes
HOST_PORT=2000                                          # default: 2000
DEV_ENVIRONMENT=true                                    # default: false
HAMMER_VERSION=v1.0.12                                  # default: false (pulls latest release)
```

* `CLEANSLATE_THEMES` variable enables setting any path to your cleanslate theme directory
* `HOST_PORT` variable enables setting any port for the VM to bind Hammer server on
* `DEV_ENVIRONMENT` variable enables latest commit versions of Hammer to be installed
* `HAMMER_VERSION` variable pins installation of a specific released versions of Hammer
