# == Class: blazar::deps
#
# blazar anchors and dependency management
#
class blazar::deps {
  # Setup anchors for install, config and service phases of the module.  These
  # anchors allow external modules to hook the begin and end of any of these
  # phases.  Package or service management can also be replaced by ensuring the
  # package is absent or turning off service management and having the
  # replacement depend on the appropriate anchors.  When applicable, end tags
  # should be notified so that subscribers can determine if installation,
  # config or service state changed and act on that if needed.
  anchor { 'blazar::install::begin': }
  -> Package<| tag == 'blazar-package'|>
  ~> anchor { 'blazar::install::end': }
  -> anchor { 'blazar::config::begin': }
  -> Blazar_config<||>
  ~> anchor { 'blazar::config::end': }
  -> anchor { 'blazar::db::begin': }
  -> anchor { 'blazar::db::end': }
  ~> anchor { 'blazar::dbsync::begin': }
  -> anchor { 'blazar::dbsync::end': }
  ~> anchor { 'blazar::service::begin': }
  ~> Service<| tag == 'blazar-service' |>
  ~> anchor { 'blazar::service::end': }

  # all db settings should be applied and all packages should be installed
  # before dbsync starts
  Oslo::Db<||> -> Anchor['blazar::dbsync::begin']

  # policy config should occur in the config block also.
  Anchor['blazar::config::begin']
  -> Openstacklib::Policy::Base<||>
  ~> Anchor['blazar::config::end']

  # Installation or config changes will always restart services.
  Anchor['blazar::install::end'] ~> Anchor['blazar::service::begin']
  Anchor['blazar::config::end']  ~> Anchor['blazar::service::begin']
}
