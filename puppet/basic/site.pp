node default {
  include profile::base
  include profile::rsyslog::client
  include profile::freeipa::client
}

node /^login\d+$/ {
  include profile::base
  include profile::fail2ban
  include profile::rsyslog::client
  include profile::slurm::submitter
  include profile::freeipa::client
  include profile::nfs::client
}

node /^mgmt01$/ {
  include profile::rsyslog::server
  include profile::freeipa::server
  include profile::squid::server
  include profile::slurm::controller
  include profile::nfs::server
  
  include profile::base
  include profile::freeipa::guest_accounts
  include profile::slurm::accounting
}

node /^mgmt0*(?:[2-9]|[1-9]\d\d*)$/ {
  include profile::base
  include profile::rsyslog::client
  include profile::freeipa::client
}

node /^node\d+$/ {
  include profile::base
  include profile::rsyslog::client
  include profile::gpu

  include profile::nfs::client
  include profile::freeipa::client
  include profile::slurm::node
  Class['profile::freeipa::client'] -> Class['profile::slurm::node']
  Class['profile::nfs::client'] -> Class['profile::slurm::node']
}
