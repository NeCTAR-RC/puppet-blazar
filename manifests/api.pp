# Class blazar::api
#
# Configure the API service in Blazar
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
class blazar::api (
  $package_ensure               = 'present',
  $enabled                      = true,
) inherits blazar::params {

  include ::blazar::deps
  include ::blazar::params
  include ::blazar::policy

  if $enabled {
    $ensure = 'running'
  } else {
    $ensure = 'stopped'
  }

  service { 'blazar-api':
    ensure     => $ensure,
    name       => $::blazar::params::api_service,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    tag        => 'blazar-service',
  }
  Keystone_endpoint<||> -> Service['blazar-api']

}
