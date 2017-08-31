# == Class: blazar::db::postgresql
#
# Class that configures postgresql for blazar
# Requires the Puppetlabs postgresql module.
#
# === Parameters
#
# [*password*]
#   (Required) Password to connect to the database.
#
# [*dbname*]
#   (Optional) Name of the database.
#   Defaults to 'blazar'.
#
# [*user*]
#   (Optional) User to connect to the database.
#   Defaults to 'blazar'.
#
#  [*encoding*]
#    (Optional) The charset to use for the database.
#    Default to undef.
#
#  [*privileges*]
#    (Optional) Privileges given to the database user.
#    Default to 'ALL'
#
# == Dependencies
#
# == Examples
#
# == Authors
#
# == Copyright
#
class blazar::db::postgresql(
  $password,
  $dbname     = 'blazar',
  $user       = 'blazar',
  $encoding   = undef,
  $privileges = 'ALL',
) {

  include ::blazar::deps

  Class['blazar::db::postgresql'] -> Service<| title == 'blazar' |>

  ::openstacklib::db::postgresql { 'blazar':
    password_hash => postgresql_password($user, $password),
    dbname        => $dbname,
    user          => $user,
    encoding      => $encoding,
    privileges    => $privileges,
  }

  ::Openstacklib::Db::Postgresql['blazar'] ~> Exec<| title == 'blazar-db-manage upgrade head' |>

}
