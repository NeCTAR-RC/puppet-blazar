#
# Class to execute blazar-db-manage upgrade head
#
# == Parameters
#
# [*extra_params*]
#   (optional) String of extra command line parameters to append
#   to the blazar-dbsync command.
#   Defaults to undef
#
class blazar::db::sync(
  $extra_params  = undef,
) {

  include ::blazar::deps

  exec { 'blazar-db-sync':
    command     => "blazar-db-manage --config-file /etc/blazar/blazar.conf upgrade head ${extra_params}",
    path        => [ '/bin', '/usr/bin', ],
    user        => 'blazar',
    refreshonly => true,
    try_sleep   => 5,
    tries       => 10,
    logoutput   => on_failure,
    subscribe   => [
      Anchor['blazar::install::end'],
      Anchor['blazar::config::end'],
      Anchor['blazar::dbsync::begin']
    ],
    notify      => Anchor['blazar::dbsync::end'],
  }
}
