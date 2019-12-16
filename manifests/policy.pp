# == Class: blazar::policy
#
# Configure the blazar policies
#
# === Parameters
#
# [*policies*]
#   (optional) Set of policies to configure for blazar
#   Example :
#     {
#       'blazar-context_is_admin' => {
#         'key' => 'context_is_admin',
#         'value' => 'true'
#       },
#       'blazar-default' => {
#         'key' => 'default',
#         'value' => 'rule:admin_or_owner'
#       }
#     }
#   Defaults to empty hash.
#
# [*policy_path*]
#   (optional) Path to the nova policy.json file
#   Defaults to /etc/blazar/policy.yaml
#
class blazar::policy (
  $policies    = {},
  $policy_path = '/etc/blazar/policy.yaml',
) {

  include ::blazar::deps

  validate_hash($policies)

  Openstacklib::Policy::Base {
    file_path => $policy_path,
  }

  create_resources('openstacklib::policy::base', $policies)

  oslo::policy { 'blazar_config': policy_file => $policy_path }

}
