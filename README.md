# A Virtual Machine for Hammer

## Introduction

This project automates the setup of a development environment for working with [Hammer](https://github.com/wvuweb/hammer).

## Installation Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) Install with: `vagrant plugin install vagrant-triggers`

## How To Build The Hammer Virtual Machine

Building the virtual machine is this easy:
```
git clone https://github.com/wvuweb/hammer-vm.git
```

Make sure that you clone this VM repo into the same directory level as your `cleanslate_themes` folder

Example:
```
/Sites/
 |_/cleanslate_themes/
 |_/hammer-vm/
```

Then change directory into the new `hammer-vm` folder and run `vagrant up`

```
cd hammer-vm
vagrant up
```

When the vagrant build process finishes you should be able to access your themes in the browser at [localhost:2000](http://localhost:2000)

If the build fails run `vagrant provision` until it completes.  If you have continue to have issues, open an [issue](https://github.com/wvuweb/hammer-vm/issues).

## Commands

To be ran from the `/hammer-vm/` directory
```
vagrant up              #Start Hammer
vagrant halt            #Stop Hammer
vagrant hammer update   #Update Hammer
```

##Mac/Linux Alias

If you would like to have aliases for the above command add the following to your `.bash_profile`, `.bashrc`, or `.profile` in your user root directory.

```
alias hammer-start="cd ~/Sites/hammer-vm && vagrant up"
alias hammer-stop="cd ~/Sites/hammer-vm && vagrant halt"
alias hammer-update="cd ~/Sites/hammer-vm && vagrant hammer update"
```
