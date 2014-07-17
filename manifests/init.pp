# == Class: rserve
#
# Full description of class rserve here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { r:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class rserve (
  $service_name         = $::rserve::params::service_name,
  $manage_firewall      = true,
  $service_enable       = true,
  $service_ensure       = 'running',
  $user                 = $::rserve::params::user,
  $group                = $::rserve::params::group,
  $rserve_version = '1.7-3',
  $rtemp_directory = '/var/rtemp',
  $rserve_opts = '--gui-none --RS-enable-control --RS-enable-remote --no-save',
  $rserve_bin = '/usr/lib64/R/bin/Rserve',
  $r_home = '/usr/lib64/R',
) inherits ::rserve::params {

  include r
  package {$::rserve::params::r_dev_package:
    ensure => installed
  }
  include rserve::package

  user { $user:
    ensure  => present,
    gid     => $group,
  }

  group { $group:
    ensure  => present,
  }

  class { '::rserve::service':
    service_name   => $service_name,
    service_enable => $service_enable,
    service_ensure => $service_ensure,
    require        => R::Package[$::rserve::params::rserve_name],
  }

  Exec {
    path => '/bin:/sbin:/usr/bin:/usr/sbin',
  }

  # set up R temp directory, in RHEL, tempwatch cron job will wipe out /tmp
  # directory automaticly. We need a separate directory for R temp folder.
  file { $rtemp_directory:
    ensure => directory,
    owner  => $user,
    group  => $group,
  }

  #wget::fetch { "Rserve":
  #  source      => "http://cran.r-project.org/src/contrib/Rserve_$rserve_version.tar.gz",
  #  destination => "/tmp/Rserve_$rserve_version.tar.gz",
  #  timeout     => 0,
  #  verbose     => false,
  #} ->

  #exec { 'Install Rserve':
  # command => "R CMD INSTALL /tmp/Rserve_$rserve_version.tar.gz",
  # path => '/bin:/usr/bin:/sbin:/usr/sbin',
  # creates => '/usr/lib64/R/library/Rserve'
  #}

  if $manage_firewall {
    firewall { '150 allow Rserve connection':
      port   => [6311],
      proto  => tcp,
      action => accept,
    }
  }
}
