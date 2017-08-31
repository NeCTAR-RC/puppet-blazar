# == Class: blazar::config
#
# This class is used to manage arbitrary blazar configurations.
#
# === Parameters
#
# [*blazar_config*]
#   (optional) Allow configuration of arbitrary blazar configurations.
#   The value is an hash of blazar_config resources. Example:
#   { 'DEFAULT/foo' => { value => 'fooValue'},
#     'DEFAULT/bar' => { value => 'barValue'}
#   }
#   In yaml format, Example:
#   blazar_config:
#     DEFAULT/foo:
#       value: fooValue
#     DEFAULT/bar:
#       value: barValue
#
#   NOTE: The configuration MUST NOT be already handled by this module
#   or Puppet catalog compilation will fail with duplicate resources.
#
class blazar::config (
  $blazar_config = {},
) {

  include ::blazar::deps

  validate_hash($blazar_config)

  create_resources('blazar_config', $blazar_config)
}
