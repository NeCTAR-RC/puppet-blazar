# == Class: blazar
#
# Installs the blazar package and configures /etc/blazar/blazar.conf
#
# === Parameters
#
# [*enabled*]
#   (required) Whether or not to enable the blazar service
#   true/false
#
# [*package_ensure*]
#   (optional) The state of the package
#   Defaults to 'present'
#
# [*debug*]
#   (optional) Print debug messages in the logs
#   Defaults to False
#
# [*auth_strategy*]
#   (optional) Default protocol to use when connecting to glance
#   Defaults to 'keystone'. 'https' is the only other valid option for SSL
#
# [*rpc_response_timeout*]
#   (optional) Seconds to wait for a response from a call. (integer value)
#   Defaults to $facts['os_service_default'].
#
# [*control_exchange*]
#   (optional) What RPC queue/exchange to use (string value)
#   Defaults to $facts['os_service_default']
#
# [*default_transport_url*]
#    (optional) A URL representing the messaging driver to use and its full
#    configuration. Transport URLs take the form:
#      transport://user:pass@host1:port[,hostN:portN]/virtual_host
#    Defaults to $facts['os_service_default']
#
# [*rpc_backend*]
#   (optional) what rpc/queuing service to use (string value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_use_ssl*]
#   (optional) Connect over SSL for RabbitMQ. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_ha_queues*]
#   (optional) Use HA queues in RabbitMQ. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_heartbeat_timeout_threshold*]
#   (optional) Number of seconds after which the RabbitMQ broker is considered
#   down if the heartbeat keepalive fails.  Any value >0 enables heartbeats.
#   Heartbeating helps to ensure the TCP connection to RabbitMQ isn't silently
#   closed, resulting in missed or lost messages from the queue.
#   Requires kombu >= 3.0.7 and amqp >= 1.4.0. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*rabbit_heartbeat_rate*]
#   (optional) How often during the rabbit_heartbeat_timeout_threshold period
#   to check the heartbeat on RabbitMQ connection.
#   i.e. rabbit_heartbeat_rate=2 when rabbit_heartbeat_timeout_threshold=60,
#   the heartbeat will be checked every 30 seconds. (integer value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_ca_certs*]
#   (optional) SSL certification authority file (valid only if SSL enabled).
#   (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_certfile*]
#   (optional) SSL cert file (valid only if SSL enabled). (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_keyfile*]
#   (optional) SSL key file (valid only if SSL enabled). (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_ssl_version*]
#   (optional) SSL version to use (valid only if SSL enabled).
#   Valid values are TLSv1, SSLv23 and SSLv3. SSLv2 may be
#   available on some distributions. (string value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_reconnect_delay*]
#   (optional) How long to wait before reconnecting in response to an AMQP
#   consumer cancel notification. (floating point value)
#   Defaults to $facts['os_service_default']
#
# [*kombu_compression*]
#   (optional) Possible values are: gzip, bz2. If not set compression will not
#   be used. This option may notbe available in future versions. EXPERIMENTAL.
#   (string value)
#   Defaults to $facts['os_service_default']
#
# [*amqp_durable_queues*]
#   (optional) Define queues as "durable" to rabbitmq. (boolean value)
#   Defaults to $facts['os_service_default']
#
# [*amqp_server_request_prefix*]
#   (Optional) Address prefix used when sending to a specific server
#   Defaults to $facts['os_service_default'].
#
# [*amqp_broadcast_prefix*]
#   (Optional) address prefix used when broadcasting to all servers
#   Defaults to $facts['os_service_default'].
#
# [*amqp_group_request_prefix*]
#   (Optional) address prefix when sending to any server in group
#   Defaults to $facts['os_service_default'].
#
# [*amqp_container_name*]
#   (Optional) Name for the AMQP container
#   Defaults to $facts['os_service_default'].
#
# [*amqp_idle_timeout*]
#   (Optional) Timeout for inactive connections
#   Defaults to $facts['os_service_default'].
#
# [*amqp_trace*]
#   (Optional) Debug: dump AMQP frames to stdout
#   Defaults to $facts['os_service_default'].
#
# [*amqp_ssl_ca_file*]
#   (Optional) CA certificate PEM file to verify server certificate
#   Defaults to $facts['os_service_default'].
#
# [*amqp_ssl_cert_file*]
#   (Optional) Identifying certificate PEM file to present to clients
#   Defaults to $facts['os_service_default'].
#
# [*amqp_ssl_key_file*]
#   (Optional) Private key PEM file used to sign cert_file certificate
#   Defaults to $facts['os_service_default'].
#
# [*amqp_ssl_key_password*]
#   (Optional) Password for decrypting ssl_key_file (if encrypted)
#   Defaults to $facts['os_service_default'].
#
# [*amqp_allow_insecure_clients*]
#   (Optional) Accept clients using either SSL or plain TCP
#   Defaults to $facts['os_service_default'].
#
# [*amqp_sasl_mechanisms*]
#   (Optional) Space separated list of acceptable SASL mechanisms
#   Defaults to $facts['os_service_default'].
#
# [*amqp_sasl_config_dir*]
#   (Optional) Path to directory that contains the SASL configuration
#   Defaults to $facts['os_service_default'].
#
# [*amqp_sasl_config_name*]
#   (Optional) Name of configuration file (without .conf suffix)
#   Defaults to $facts['os_service_default'].
#
# [*amqp_username*]
#   (Optional) User name for message broker authentication
#   Defaults to $facts['os_service_default'].
#
# [*amqp_password*]
#   (Optional) Password for message broker authentication
#   Defaults to $facts['os_service_default'].
#
# [*nova_client_version*]
#   (Optional) Nova client version to use
#   Defaults to $facts['os_service_default'].
#
# [*use_syslog*]
#   (optional) Use syslog for logging
#   Defaults to undef.
#
# [*log_facility*]
#   (optional) Syslog facility to receive log lines
#   Defaults to undef.
#
# [*use_stderr*]
#   (optional) Use stderr for logging
#   Defaults to undef.
#
# [*log_dir*]
#   (optional) Directory where logs should be stored.
#   If set to $facts['os_service_default'], it will not log to any directory.
#   Defaults to undef.
#
# [*sync_db*]
#   Enable dbsync
#   Defaults to true
#
# [*notification_transport_url*]
#   (Optional) A URL representing the messaging driver to use for notifications
#   and its full configuration. Transport URLs take the form:
#     transport://user:pass@host1:port[,hostN:portN]/virtual_host
#   Defaults to $facts['os_service_default']
#
# [*notification_driver*]
#   (Option) Driver or drivers to handle sending notifications.
#   Defaults to $facts['os_service_default']
#
# [*notification_topics*]
#   (Optional) AMQP topic used for OpenStack notifications
#   Defaults to $facts['os_service_default']
#
# [*purge_config*]
#   (optional) Whether to set only the specified config options
#   in the blazar config.
#   Defaults to false.
#
class blazar (
  $enabled                            = true,
  $package_ensure                     = 'present',
  $debug                              = undef,
  $use_syslog                         = undef,
  $use_stderr                         = undef,
  $log_facility                       = undef,
  $log_dir                            = undef,
  $auth_strategy                      = 'keystone',
  $control_exchange                   = $facts['os_service_default'],
  $rpc_response_timeout               = $facts['os_service_default'],
  $default_transport_url              = $facts['os_service_default'],
  $rpc_backend                        = $facts['os_service_default'],
  $rabbit_use_ssl                     = $facts['os_service_default'],
  $rabbit_heartbeat_timeout_threshold = $facts['os_service_default'],
  $rabbit_heartbeat_rate              = $facts['os_service_default'],
  $rabbit_ha_queues                   = $facts['os_service_default'],
  $kombu_ssl_ca_certs                 = $facts['os_service_default'],
  $kombu_ssl_certfile                 = $facts['os_service_default'],
  $kombu_ssl_keyfile                  = $facts['os_service_default'],
  $kombu_ssl_version                  = $facts['os_service_default'],
  $kombu_reconnect_delay              = $facts['os_service_default'],
  $kombu_compression                  = $facts['os_service_default'],
  $amqp_durable_queues                = $facts['os_service_default'],
  $amqp_server_request_prefix         = $facts['os_service_default'],
  $amqp_broadcast_prefix              = $facts['os_service_default'],
  $amqp_group_request_prefix          = $facts['os_service_default'],
  $amqp_container_name                = $facts['os_service_default'],
  $amqp_idle_timeout                  = $facts['os_service_default'],
  $amqp_trace                         = $facts['os_service_default'],
  $amqp_ssl_ca_file                   = $facts['os_service_default'],
  $amqp_ssl_cert_file                 = $facts['os_service_default'],
  $amqp_ssl_key_file                  = $facts['os_service_default'],
  $amqp_ssl_key_password              = $facts['os_service_default'],
  $amqp_allow_insecure_clients        = $facts['os_service_default'],
  $amqp_sasl_mechanisms               = $facts['os_service_default'],
  $amqp_sasl_config_dir               = $facts['os_service_default'],
  $amqp_sasl_config_name              = $facts['os_service_default'],
  $amqp_username                      = $facts['os_service_default'],
  $amqp_password                      = $facts['os_service_default'],
  $notification_transport_url         = $facts['os_service_default'],
  $notification_driver                = $facts['os_service_default'],
  $notification_topics                = $facts['os_service_default'],
  $sync_db                            = true,
  $purge_config                       = false,
  $manager_plugins                    = [],
  $event_max_retries                  = $facts['os_service_default'],
  $nova_client_version                = $facts['os_service_default'],
) {

  include blazar::db
  include blazar::deps
  include blazar::logging
  include blazar::params

  package { 'blazar-common':
    ensure => $package_ensure,
    name   => $blazar::params::service_package,
    tag    => ['openstack', 'blazar-package'],
  }

  resources { 'blazar_config':
    purge => $purge_config,
  }

  blazar_config {
    'DEFAULT/auth_strategy':           value => $auth_strategy;
    'manager/plugins':                 value => join($manager_plugins, ',');
    'manager/event_max_retries':       value => $event_max_retries;
    'nova/nova_client_version':        value => $nova_client_version;
  }

  if $sync_db {
    include blazar::db::sync
  }

  oslo::messaging::notifications { 'blazar_config':
    transport_url => $notification_transport_url,
    driver        => $notification_driver,
    topics        => $notification_topics,
  }

  oslo::messaging::default {'blazar_config':
      transport_url        => $default_transport_url,
      rpc_response_timeout => $rpc_response_timeout,
      control_exchange     => $control_exchange,
  }

  if $rpc_backend in [$facts['os_service_default'], 'blazar.openstack.common.rpc.impl_kombu', 'rabbit'] {
    oslo::messaging::rabbit {'blazar_config':
      rabbit_use_ssl              => $rabbit_use_ssl,
      heartbeat_timeout_threshold => $rabbit_heartbeat_timeout_threshold,
      heartbeat_rate              => $rabbit_heartbeat_rate,
      kombu_reconnect_delay       => $kombu_reconnect_delay,
      amqp_durable_queues         => $amqp_durable_queues,
      kombu_compression           => $kombu_compression,
      kombu_ssl_ca_certs          => $kombu_ssl_ca_certs,
      kombu_ssl_certfile          => $kombu_ssl_certfile,
      kombu_ssl_keyfile           => $kombu_ssl_keyfile,
      kombu_ssl_version           => $kombu_ssl_version,
      rabbit_ha_queues            => $rabbit_ha_queues,
    }
  } elsif $rpc_backend == 'amqp' {
    oslo::messaging::amqp { 'blazar_config':
      server_request_prefix  => $amqp_server_request_prefix,
      broadcast_prefix       => $amqp_broadcast_prefix,
      group_request_prefix   => $amqp_group_request_prefix,
      container_name         => $amqp_container_name,
      idle_timeout           => $amqp_idle_timeout,
      trace                  => $amqp_trace,
      ssl_ca_file            => $amqp_ssl_ca_file,
      ssl_cert_file          => $amqp_ssl_cert_file,
      ssl_key_file           => $amqp_ssl_key_file,
      ssl_key_password       => $amqp_ssl_key_password,
      allow_insecure_clients => $amqp_allow_insecure_clients,
      sasl_mechanisms        => $amqp_sasl_mechanisms,
      sasl_config_dir        => $amqp_sasl_config_dir,
      sasl_config_name       => $amqp_sasl_config_name,
      username               => $amqp_username,
      password               => $amqp_password,
    }
  } else {
    blazar_config { 'DEFAULT/rpc_backend': value => $rpc_backend }
  }

}
