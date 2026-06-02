# Class blazar::placement
#
#  Manages the blazar placement package on systems
#
# == parameters
#
# [*endpoint_type*]
#   (optional) The type of placement endpoint to use when
#   looking up in the keystone catalog.
#   Defaults to $facts['os_service_default']
#
# [*region_name*]
#   (optional) Region name for connecting to placement
#   Defaults to $facts['os_service_default']

class blazar::placement(
  $package_ensure            = present,
  $endpoint_type             = $facts['os_service_default'],
  $region_name               = $facts['os_service_default'],
) {

  include blazar::deps
  include blazar::params

  blazar_config {
    'placement/endpoint_type': value => $endpoint_type;
    'placement/region_name':   value => $region_name;
  }
}
