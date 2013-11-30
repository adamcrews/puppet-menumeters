require 'spec_helper'
# Rename this file to classname_spec.rb
# Check other boxen modules for examples
# or read http://rspec-puppet.com/tutorial/
describe 'menumeters' do
  it do
    should contain_package('menumeters')
  end
end
