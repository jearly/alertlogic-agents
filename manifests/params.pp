# Class: puppet::params
#
# This class installs and configures parameters for Puppet
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class al_agents::params {
  $architecture     = $::architecture
  $registration_key = 'your_registration_key_here'
  $egress_url       = 'vaporator.alertlogic.com'
  $egress_port      = 443
  $service_ensure   = 'running'
  $syslogng_detected = syslogng_detected()
  $rsyslog_detected = rsyslog_detected()
  $proxy_url        = undef
  $for_imaging      = undef
  case $::operatingsystem {
    'Centos', 'Redhat', 'Fedora', 'Scientific': {
      $al_agent_service = 'al-agent'
      if $::operatingsystemrelease >= 6 {
          $source_log = 's_all'
      }
      else {
          $source_log = 's_sys'
      }
      case $::architecture {
        'x86_64', 'amd64': {
          $al_agent_package = 'https://scc.alertlogic.net/software/al-agent-LATEST-1.x86_64.rpm'
        }
        default: {
          $al_agent_package = 'https://scc.alertlogic.net/software/al-agent-LATEST-1.i386.rpm'
        }
      }
    }
    'Ubuntu', 'Debian': {
      $al_agent_service = 'al-agent'
      $source_log = 's_src'
      case $::architecture {
        'x86_64', 'amd64': {
          $al_agent_package = 'https://scc.alertlogic.net/software/al-agent_LATEST_amd64.deb'
        }
        default: {
          $al_agent_package = 'https://scc.alertlogic.net/software/al-agent_LATEST_i386.deb'
        }
      }
    }
    'Windows': {
      $al_agent_service = 'al_agent'
      $al_agent_package = 'https://scc.alertlogic.net/software/al_agent-LATEST.msi'
      case $::architecture {
        'x86_64', 'amd64': {
          $windows_install_guard = 'C:\Program Files (x86)\Common Files\AlertLogic\host_key.pem'
        }
        default: {
          $windows_install_guard = 'C:\Program Files\Common Files\AlertLogic\host_key.pem'
        }
      }
    }
    default: {
      $al_agent_package = 'https://scc.alertlogic.net/software/al-agent_LATEST_amd64.deb'
    }
  }
}
