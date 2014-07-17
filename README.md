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

## Release Notes

Initial release
