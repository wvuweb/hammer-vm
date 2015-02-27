# A Virtual Machine for Hammer

## Introduction

This project automates the setup of a development environment for working with Hammer.

## Installation Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

* [Vagrant Triggers](https://github.com/emyl/vagrant-triggers) Install with: `vagrant plugin install vagrant-triggers`

## How To Build The Hammer Virtual Machine

Building the virtual machine is this easy:
```
$ git clone https://github.com/wvuweb/hammer-vm.git
$ cd hammer-vm
$ vagrant up
```

The only other requirement is making sure that you clone this VM repo into the same directory level as your `cleanslate_themes` folder

Example:
```
/Sites/
 |_cleanslate_themes
 |_hammer-vm
```

When the vagrant process finishes you should be able to access your themes in the browser at `localhost:2000`
