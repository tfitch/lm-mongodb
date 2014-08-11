#
# Cookbook Name:: lm-mongodb
# Attributes:: default
#
# Copyright (c) 2014 Tyler Fitch
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

# YEP - total lifted from community mongodb cookbook

# cluster identifier
default[:mongodb][:client_roles] = []
default[:mongodb][:cluster_name] = nil
default[:mongodb][:shard_name] = 'default'

# replica options
default[:mongodb][:replica_arbiter_only] = false
default[:mongodb][:replica_build_indexes] = true
default[:mongodb][:replica_hidden] = false
default[:mongodb][:replica_slave_delay] = 0
default[:mongodb][:replica_priority] = 1
default[:mongodb][:replica_tags] = {}
default[:mongodb][:replica_votes] = 1

default[:mongodb][:auto_configure][:replicaset] = true
default[:mongodb][:auto_configure][:sharding] = true

# don't use the node's fqdn, but this url instead; something like 'ec2-x-y-z-z.aws.com' or 'cs1.domain.com' (no port)
# if not provided, will fall back to the FQDN
default[:mongodb][:configserver_url] = nil

default[:mongodb][:root_group] = 'root'
default[:mongodb][:user] = 'mongodb'
default[:mongodb][:group] = 'mongodb'

default[:mongodb][:init_dir] = '/etc/init.d'
default[:mongodb][:init_script_template] = 'debian-mongodb.init.erb'
default[:mongodb][:sysconfig_file] = '/etc/default/mongodb'
default[:mongodb][:sysconfig_file_template] = 'mongodb.sysconfig.erb'
default[:mongodb][:dbconfig_file_template] = 'mongodb.conf.erb'
default[:mongodb][:dbconfig_file] = '/etc/mongodb.conf'

default[:mongodb][:package_name] = 'mongodb'
default[:mongodb][:package_version] = nil

default[:mongodb][:default_init_name] = 'mongodb'
default[:mongodb][:instance_name] = 'mongodb'

# this option can be "distro" or "mongodb-org"
default[:mongodb][:install_method] = 'distro'

default[:mongodb][:is_replicaset] = nil
default[:mongodb][:is_shard] = nil
default[:mongodb][:is_configserver] = nil

default[:mongodb][:reload_action] = 'restart' # or "nothing"

# determine the package name
# from http://rpm.pbone.net/index.php3?stat=3&limit=1&srodzaj=3&dl=40&search=mongodb
# verified for RHEL5,6 Fedora 18,19
default[:mongodb][:package_name] = 'mongodb-server'
default[:mongodb][:sysconfig_file] = '/etc/sysconfig/mongodb'
default[:mongodb][:user] = 'mongod'
default[:mongodb][:group] = 'mongod'
default[:mongodb][:init_script_template] = 'mongodb.init.erb'
default[:mongodb][:default_init_name] = 'mongod'
default[:mongodb][:instance_name] = 'mongod'
# then there is this guy
if node['platform'] == 'centos' || node['platform'] == 'amazon'
  Chef::Log.warn("CentOS doesn't provide mongodb, forcing use of mongodb-org repo")
  default[:mongodb][:install_method] = 'mongodb-org'
  default[:mongodb][:package_name] = 'mongodb-org'
end

default[:mongodb][:template_cookbook] = 'lm-mongodb'

default[:mongodb][:key_file_content] = nil

# install the mongo and bson_ext ruby gems at compile time to make them globally available
# TODO: remove bson_ext once mongo gem supports bson >= 2
default['mongodb']['ruby_gems'] = {
  :mongo => nil,
  :bson_ext => nil
}