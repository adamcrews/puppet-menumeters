# == Class: menumeters
#
# Install menumeters, by default to the current user's Library folder.
#
# === Parameters
#
# [*installer_source*]
#   String of URL to MenuMeters.dmg.
#
#   default: http://www.ragingmenace.com/software/download/MenuMeters.dmg
#
# [*installer_tool*]
#   String of full path to MenuMeters' install script.
#
#   default: /Applications/MenuMeters Installer.app/Contents/Resources/InstallTool
#
# [*installer_method*]
#   String indicating method of MenuMeters install. Valid options:
#
#   user - Install MenuMeters to current user's Library folder
#   system - Install MenuMeters to system-wide Library folder
#
#   default: user
#
# === Variables
#
# None.
#
# === Examples
#
# include menumeters
#
# === Authors
#
# Adam Crews <adam@puppetlabs.com>
# David Warden <dfwarden@gmail.com>
#
# === Copyright
#
# Copyright 2013 Adam Crews, unless otherwise nodted.
#
class menumeters (
  $installer_source = 'http://www.ragingmenace.com/software/download/MenuMeters.dmg',
  $installer_tool = '/Applications/MenuMeters Installer.app/Contents/Resources/InstallTool',
  $installer_method = 'user',
) {

  case $installer_method {
    'user': {
      $installer_user = $::boxen_user
      $installer_creates = "/Users/${::boxen_user}/Library/PreferencePanes/MenuMeters.prefPane"
      $installer_flag = '--installuser'
    }
    'system': {
      $installer_user = 'root'
      $installer_creates = '/Library/PreferencePanes/MenuMeters.prefPane'
      $installer_flag = '--installlibrary'
    }
    default: {
      fail("\$installer_method must be user or system, not ${installer_method}")
    }
  }

  package { 'menumeters':
    ensure   => installed,
    source   => $installer_source,
    provider => 'appdmg',
    before   => Exec['exec_menumeters_prefpane_install'],
  }

  exec { 'exec_menumeters_prefpane_install':
    command  => "\"${installer_tool}\" ${installer_flag}",
    creates  => $installer_creates,
    user     => $installer_user,
  }

}
