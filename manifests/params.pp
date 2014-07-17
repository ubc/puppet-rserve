# Class: rserve::params
#
# This class manages Rserve parameters
#
# Parameters:
# - The $user that Rserve runs as
# - The $group that Rserve runs as
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class rserve::params {
  $user = 'rserve'
  $group = 'rserve'
  $service_name = 'rserve'
  $rserve_name = 'Rserve'

  case $::osfamily {
    'redhat': {
      include epel
      $service_install_cmd = '/sbin/chkconfig --add rserve'
      $service_test_cmd = 'test `/sbin/chkconfig --list | /bin/grep rserve | /usr/bin/wc -l` -eq 0'
      $r_dev_package = 'R-core-devel'
    }
    'debian': {
      $service_install_cmd = 'echo hello'
      $service_test_cmd = "false"
      $r_dev_package = 'r-base-dev'
    }
    default: { fail("Class['r::params']: Unsupported osfamily: ${::osfamily}") }
  }
}
