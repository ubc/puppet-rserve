# Class: rserve::service
#
# Manages the Rserve daemon
#
# Parameters:
#
# Actions:
#   - Manage Rserve service
#
# Requires:
#
# Sample Usage:
#
#    sometype { 'foo':
#      notify => Class['rserve::service'],
#    }
#
#
class rserve::service (
  $service_name   = $::rserve::params::service_name,
  $service_enable = true,
  $service_ensure = 'running',
) {
  validate_bool($service_enable)

  case $service_ensure {
    true, false, 'running', 'stopped': {
      $_service_ensure = $service_ensure
    }
    default: {
      $_service_ensure = undef
    }
  }

  file { 'rserve':
    path    => '/etc/init.d/rserve',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template("rserve/rserve.${::osfamily}.erb"),
  } ->

  exec { 'add_rserve_service':
    command => $::rserve::params::service_install_cmd,
    path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    onlyif  => $::rserve::params::service_test_cmd,
  } ->

  service { 'rserve':
    ensure => $_service_ensure,
    name   => $service_name,
    enable => $service_enable,
  }
}
