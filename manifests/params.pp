# Parameters for puppet-blazar
#
class blazar::params {

  include openstacklib::defaults

  $client_package_name = 'python3-blazarclient'
  $user                = 'blazar'
  $group               = 'blazar'

  case $facts['os']['family'] {
    'RedHat': {
      $api_package     = 'openstack-blazar-api'
      $manager_package = 'openstack-blazar-manager'
      $service_package = 'python3-blazar'
      $nova_package    = 'openstack-blazar-nova'
      $api_service     = 'openstack-blazar-api'
      $manager_service = 'openstack-blazar-manager'
    }
    'Debian': {
      $api_package     = 'blazar-api'
      $manager_package = 'blazar-manager'
      $service_package = 'python3-blazar'
      $nova_package    = 'python3-blazarnova'
      $api_service     = 'blazar-api'
      $manager_service = 'blazar-manager'
    }
    default: {
      fail("unsupported osfamily ${facts['os']['family']}, currently Debian and Redhat are the only supported platforms")
    }
  }
}
