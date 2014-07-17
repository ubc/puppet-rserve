class rserve::package (
) inherits ::rserve::params {
  r::package {$::rserve::params::rserve_name:
    dependencies => true,
    notify       => Class['::rserve::service'],
  }
}
