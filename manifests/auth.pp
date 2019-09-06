# The blazar::auth class helps configure service credentials
#
# == Parameters
#  [*os_auth_protocol*]
#    the keystone protocol
#    Optional. Defaults to $::os_service_default.'
#
#  [*os_region_name*]
#    the keystone region of this node
#    Optional. Defaults to $::os_service_default.
#
#  [*os_admin_username*]
#    the keystone user for blazar services
#    Optional. Defaults to $::os_service_default.
#
#  [*os_admin_password*]
#    the keystone password for blazar services
#    Required.
#
#  [*os_admin_project_name*]
#    the keystone tenant name for blazar services
#    Optional. Defaults to $::os_service_default.
#
#  [*os_admin_project_domain_name*]
#    the keystone project domain name for blazar services
#    Optional. Defaults to $::os_service_default.
#
#  [*os_admin_user_domain_name*]
#    the keystone user domain name foe blazar services
#    Optional. Defaults to $::os_service_default.
#
#  [*os_auth_version*]
#    the keystone auth version
#    Optional. Defaults to $::os_service_default.
#
#  [*os_auth_port*]
#    Port of keystone server
#    Optional. Defaults to $::os_service_default.
#
#  [*os_auth_host*]
#    Host of keystone server
#    Optional. Defaults to $::os_service_default.
#
#  [*os_auth_prefix*]
#    Prefix of keystone server
#    Optional. Defaults to $::os_service_default.
#
class blazar::auth (
  $os_admin_password,
  $os_admin_username            = $::os_service_default,
  $os_admin_project_name        = $::os_service_default,
  $os_admin_project_domain_name = $::os_service_default,
  $os_admin_user_domain_name    = $::os_service_default,
  $os_auth_protocol             = $::os_service_default,
  $os_auth_version              = $::os_service_default,
  $os_auth_port                 = $::os_service_default,
  $os_auth_host                 = $::os_service_default,
  $os_auth_prefix               = $::os_service_default,
  $os_region_name               = $::os_service_default,
) {

  include ::blazar::deps

  blazar_config {
    'DEFAULT/os_admin_username'            : value => $os_admin_username;
    'DEFAULT/os_admin_password'            : value => $os_admin_password, secret => true;
    'DEFAULT/os_admin_project_name'        : value => $os_admin_project_name;
    'DEFAULT/os_admin_project_domain_name' : value => $os_admin_project_domain_name;
    'DEFAULT/os_admin_user_domain_name'    : value => $os_admin_user_domain_name;
    'DEFAULT/os_auth_protocol'             : value => $os_auth_protocol;
    'DEFAULT/os_auth_version'              : value => $os_auth_version;
    'DEFAULT/os_auth_port'                 : value => $os_auth_port;
    'DEFAULT/os_auth_host'                 : value => $os_auth_host;
    'DEFAULT/os_auth_prefix'               : value => $os_auth_prefix;
    'DEFAULT/os_region_name'               : value => $os_region_name;
  }

}
