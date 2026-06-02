# Class blazar::nova
#
#  Manages the blazar nova package on systems
#
# == parameters
#
# [*manage_package*]
#   (Optional) manage the package
#   Defaults to true
#
# [*package_ensure*]
#   (Optional) The state of the package
#   Defaults to present
#
# [*endpoint_type*]
#   (optional) The type of nova endpoint to use when
#   looking up in the keystone catalog.
#   Defaults to $facts['os_service_default']
#
# [*region_name*]
#   (optional) Region name for connecting to nova
#   Defaults to $facts['os_service_default']

class blazar::nova(
  $package_ensure            = present,
  $manage_package            = true,
  $endpoint_type             = $facts['os_service_default'],
  $region_name               = $facts['os_service_default'],
) {

  include blazar::deps
  include blazar::params

  if $manage_package {
    package { 'openstack-blazar-nova':
      ensure => $package_ensure,
      name   => $blazar::params::nova_package,
      tag    => ['openstack', 'blazar-package'],
    }
  }
  blazar_config {
    'nova/endpoint_type': value => $endpoint_type;
    'nova/region_name':   value => $region_name;
  }
}
