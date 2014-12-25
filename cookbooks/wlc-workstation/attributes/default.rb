#
# Cookbook Name:: wlc-workstation
# Attributes:: default
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#

default['wlc-workstation']['ssl_verify'] = true
default['wlc-workstation']['user'] = 'vagrant'
default['wlc-workstation']['group'] = 'vagrant'
if node['wlc-workstation']['user'] == 'root'
  default['wlc-workstation']['user_home'] = "/#{node['wlc-workstation']['user']}"
else
  default['wlc-workstation']['user_home'] = "/home/#{node['wlc-workstation']['user']}"
end
default['wlc-workstation']['repo_url'] = 'https://github.com/welovecoding/wlc-chef-repo.git'
default['wlc-workstation']['repo_path_local'] = '/vagrant/wlc-chef-repo'


# Knife attribute override
node.override['knife']['user'] = node['wlc-workstation']['user']
node.override['knife']['group'] = node['wlc-workstation']['group']
node.override['knife']['user_home'] = node['wlc-workstation']['user_home']

node.override['knife']['log_level'] = "info"
node.override['knife']['log_location'] = "STDOUT"
node.override['knife']['node_name'] = node['fqnd']
node.override['knife']['client_key_path'] = "/etc/chef/client.pem"
node.override['knife']['validation_client_name'] = "chef-validator"
node.override['knife']['validation_key'] = "/etc/chef/validation.pem"
node.override['knife']['chef_server_url'] = "https://192.168.1.2:9191/"
node.override['knife']['ssl_verify_mode'] = "verify_none"
node.override['knife']['syntax_check_cache_path'] = "#{node['wlc-workstation']['user_home']}/.chef/syntax_check_cache"
node.override['knife']['cookbook_path'] = "#{node['wlc-workstation']['repo_path_local']}/cookbooks"
node.override['knife']['editor'] = "vi"
