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
# [*installer_flag*]
#   String of arguments to $installer_tool. Known values are
#   --installuser and --installlibrary, which are mutually
#   exclusive. Elevated privs are likely required for
#   --installlibrary, which has not been tested.
#
#   default: --installuser
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
  $installer_flag = '--installuser',
) {

  $installer_creates = $installer_flag ? {
    '--installuser' => "/Users/${::boxen_user}/Library/PreferencePanes/MenuMeters.prefPane",
    '--installlibrary' => '/Library/PreferencePanes/MenuMeters.prefPane',
    default => fail("Value for \$installer_tool must be --installuser or --installlibrary, not ${installer_tool}."),
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
  }

}
