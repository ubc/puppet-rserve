# rserve

[![Build Status](https://travis-ci.org/ubc/puppet-rserve.svg?branch=master)](https://travis-ci.org/ubc/puppet-rserve)

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with rserve](#setup)
    * [What rserve affects](#what-rserve-affects)
    * [Beginning with rserve](#beginning-with-rserve)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Overview

This module installs Rserve. It can also manage the firewall.

## Setup

### What rserve affects

* Install Rserve package
* Add rserve service
* Add rserve to startup script

### Beginning with rserve

    sudo puppet apply -e “include rserve”

## Usage

    class {‘rserve’:
      manage_firewall => false,
      rserve_version = '1.7-3',
    }

## Limitations

This module is tested with CentOS 6, RHEL 6 and Ubuntu 12.04. It should work with other derivative distros.

## Development

Fork and send pull request. Any contribution is welcome.

    git clone https://github.com/YOUR_GITHUB_NAME/puppet-rserve.git rserve
    cd rserve
    vagrant init puppetlabs/centos-6.5-64-puppet
    # or vagrant init puppetlabs/ubuntu-12.04-64-puppet
    vagrant up
    vagrant ssh
    sudo yum update
    #sudo apt-get update
    #sudo apt-get upgrade
    sudo puppet module install puppetlabs-stdlib
    sudo puppet module install stahnma-epel
    sudo puppet module install forward3ddev-r
    sudo puppet module install puppetlabs-firewall
    sudo puppet apply --modulepath=/etc/puppet/modules:/vagrant -e “include rserve”

    #to run tests, need to install the gems
    bundle install
    bundle exec rake spec

The module can be found in /vagrant

## Release Notes

Initial release
