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
  }
}
