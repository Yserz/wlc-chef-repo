#
# Cookbook Name:: wlc-chef-server
# Attributes:: default
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#
default['wlc-chef-server']['ssl_verify_mode'] = :verify_none
default['wlc-chef-server']['user'] = 'root'
default['wlc-chef-server']['group'] = 'root'
if node['wlc-chef-server']['user'] == 'root'
  default['wlc-chef-server']['user_home'] = "/#{node['wlc-chef-server']['user']}"
else
  default['wlc-chef-server']['user_home'] = "/home/#{node['wlc-chef-server']['user']}"
end
default['wlc-chef-server']['repo_url'] = 'https://github.com/opscode/chef-repo.git'
default['wlc-chef-server']['repo_path_local'] = "#{node['wlc-chef-server']['user_home']}/wlc-chef-repo"


# Knife attribute override
node.override['knife']['user'] = node['wlc-chef-server']['user']
node.override['knife']['group'] = node['wlc-chef-server']['group']
node.override['knife']['user_home'] = node['wlc-chef-server']['user_home']

node.override['knife']['log_level'] = "info"
node.override['knife']['log_location'] = "STDOUT"
node.override['knife']['node_name'] = 'admin'
node.override['knife']['client_key_path'] = "/etc/chef-server/admin.pem"
node.override['knife']['validation_client_name'] = "chef-validator"
node.override['knife']['validation_key'] = "/etc/chef-server/chef-validator.pem"
node.override['knife']['chef_server_url'] = "https://192.168.1.2:9191/"
node.override['knife']['ssl_verify_mode'] = node['wlc-chef-server']['ssl_verify_mode']
node.override['knife']['syntax_check_cache_path'] = "#{node['wlc-chef-server']['user_home']}/.chef/syntax_check_cache"
node.override['knife']['cookbook_path'] = "#{node['wlc-chef-server']['repo_path_local']}/cookbooks"
node.override['knife']['editor'] = "vi"

node.override['knife']['default_secret'] = "data_bag_master_key"
node.override['knife']['default_secret_path'] = "/etc/chef-server/"