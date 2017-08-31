# Class blazar::horizon
#
#  Manages the blazar horizon package on systems
#
# == parameters
#
#  [*git_remote_url*]
#    (Optional) Remote URL of the blazar-dashboard repository
#    Defaults to 'https://git.openstack.org/openstack/blazar-dashboard'
#
#  [*git_remote_branch*]
#    (Optional) Remote branch of the blazar-dashboard repository
#    Defaults to 'master'
#

class blazar::horizon(
  $git_remote_url    = 'https://git.openstack.org/openstack/blazar-dashboard',
  $git_remote_branch = 'master',
) {

  include ::blazar::deps
  include ::blazar::params

  vcsrepo { '/root/blazar-dashboard':
    ensure   => latest,
    provider => git,
    source   => $git_remote_url,
    revision => $git_remote_branch,
    notify   => Exec['install_blazardashboard'],
  }

  exec { 'install_blazardashboard':
    command     => 'python setup.py install',
    cwd         => '/root/blazar-dashboard',
    path        => '/usr/bin',
    require     => vcsrepo['/root/blazar-dashboard'],
    refreshonly => true,
    notify      => Service['httpd'],
  }

  file { '/usr/share/openstack-dashboard/openstack_dashboard/local/enabled/_90_project_reservations_panelgroup.py':
    ensure => 'link',
    target => '/usr/lib/python2.7/site-packages/blazar_dashboard/enabled/_90_project_reservations_panelgroup.py',
    notify => Service['httpd'],
  }

  file { '/usr/share/openstack-dashboard/openstack_dashboard/local/enabled/_91_project_reservations_leases_panel.py':
    ensure => 'link',
    target => '/usr/lib/python2.7/site-packages/blazar_dashboard/enabled/_91_project_reservations_leases_panel.py',
    notify => Service['httpd'],
  }
}
