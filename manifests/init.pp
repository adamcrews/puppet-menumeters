# == Class: menumeters
#
# Install the menumeters package
#
# === Parameters
#
# None.
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
#
# === Copyright
#
# Copyright 2013 Adam Crews, unless otherwise nodted.
#
class menumeters {
  package { 'menumeters':
    ensure   => installed,
    source   => 'http://www.ragingmenace.com/software/download/MenuMeters.dmg',
    provider => 'appdmg',
    before   => Exec['menumeters_user_library_install'],
  }

  exec { 'menumeters_user_library_install':
    command  => '"/Applications/MenuMeters Installer.app/Contents/Resources/InstallTool" --installuser',
    creates  => "/Users/${::boxen_user}/Library/PreferencePanes/MenuMeters.prefPane",
  }
}
