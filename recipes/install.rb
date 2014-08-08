#
# Cookbook Name:: lm-mongodb
# Recipe:: install
#
# Copyright (C) 2014 
#
# 
#

cookbook_file '/etc/yum.repos.d/mongodb.repo' do
	action :create_if_missing
end

# alternative
# yum_repository 'mongodb' do
#  description 'mongodb RPM Repository'
#  baseurl "http://downloads-distro.mongodb.org/repo/redhat/os/#{node['kernel']['machine']  =~ /x86_64/ ? 'x86_64' : 'i686'}"
#  action :create
#  gpgcheck false
#  enabled true
# end

# install
package 'mongodb-org' do
  options '--nogpgcheck'
  action :install
  version '2.6.3-1'
end