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
cd hammer-vm
vagrant up
```

Make sure that you clone this VM repo into the same directory level as your `cleanslate_themes` folder

Example:
```
/Sites/
 |_/cleanslate_themes/
 |_/hammer-vm/
```

When the vagrant process finishes you should be able to access your themes in the browser at [localhost:2000](http://localhost:2000)


## Commands

To be ran from the `/hammer-vm/` directory
```
vagrant up              #Start Hammer
vagrant halt            #Stop Hammer
vagrant hammer-update   #Update Hammer
```
