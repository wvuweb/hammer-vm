# A Virtual Machine for Hammer

## Introduction

This project automates the setup of a development environment for working with Hammer.

## Installation Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant](http://vagrantup.com)

## How To Build The Hammer Virtual Machine

Building the virtual machine is this easy:

    host $ git clone https://github.com/wvuweb/hammer-vm.git
    host $ cd hammer-vm
    host $ vagrant up


The only other requirement is making sure that you clone this VM into the same directory as your  `cleanslate_themes` folder

When the vagrant process finishes you should be able to access your themes at `localhost:2000`
