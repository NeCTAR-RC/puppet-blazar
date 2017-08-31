# Class blazar::client
#
#  Manages the blazar client package on systems
#
# == parameters
#
#  [*package_ensure*]
#    (Optional) The state of the package
#    Defaults to present
#

class blazar::client(
  $package_ensure = present
) {

  include ::blazar::deps
  include ::blazar::params

  package { 'python-blazarclient':
    ensure => $package_ensure,
    name   => $::blazar::params::client_package,
    tag    => ['openstack', 'blazar-support-package'],
  }
}
