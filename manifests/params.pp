# Parameters for puppet-blazar
#
class blazar::params {

  include ::blazar::deps

  include ::openstacklib::defaults

  $client_package_name = 'python-blazarclient'

  case $::osfamily {
    'RedHat': {
      $service_package = 'openstack-blazar'
      $nova_package    = 'openstack-blazar-nova'
      $api_service     = 'openstack-blazar-api'
      $manager_service = 'openstack-blazar-manager'
    }
    'Debian': {
    }
    default: {
      fail("Unsupported osfamily: ${::osfamily} operatingsystem")
    }

  } # Case $::osfamily
}
