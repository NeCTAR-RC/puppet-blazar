# Class blazar::nova
#
#  Manages the blazar nova package on systems
#
# == parameters
#
#  [*package_ensure*]
#    (Optional) The state of the package
#    Defaults to present
#

class blazar::nova(
  $package_ensure = present
) {

  include ::blazar::deps
  include ::blazar::params

  package { 'openstack-blazar-nova':
    ensure => $package_ensure,
    name   => $::blazar::params::nova_package,
    tag    => ['openstack', 'blazar-package'],
  }
}
