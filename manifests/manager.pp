# Class blazar::manager
#
# Configure the manager service in Blazar
#
# == parameters
#
# [*package_ensure*]
#   (optional) Control the ensure parameter for the package ressource.
#   Defaults to 'present'.
#
# [*enabled*]
#   (optional) Define if the service must be enabled or not.
#   Defaults to true.
#
class blazar::manager (
  $package_ensure                      = 'present',
  $enabled                             = true,
) {

  include ::blazar::deps
  include ::blazar::params

  if $enabled {
    $ensure = 'running'
  } else {
    $ensure = 'stopped'
  }

  service { 'blazar-manager':
    ensure    => $ensure,
    name      => $::blazar::params::manager_service,
    enable    => $enabled,
    hasstatus => true,
    tag       => 'blazar-service',
  }

}
