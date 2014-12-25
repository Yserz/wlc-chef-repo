#
# Cookbook Name:: wlc-chef-server
# Recipe:: default
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'tar'
include_recipe 'git'
include_recipe 'chef-server'
include_recipe 'knife'

node.default['knife']['temp_node_name'] = 'temp'
node.default['knife']['temp_client_key_path'] = '/tmp/temp.pem'

# Create a temp user
knife_user node['knife']['temp_node_name'] do
  password (0...20).map { [*('a'..'z'),*('A'..'Z'),*('0'..'9')].to_a[rand(62)] }.join
  admin true
  output_key_file_path node['knife']['temp_client_key_path']
  
  server_url node['knife']['chef_server_url']
  api_key_path node['knife']['client_key_path']
  api_client_name node['knife']['node_name']
  action :create
end

# Delete the old default admin user
knife_user "admin" do
  output_key_file_path node['knife']['client_key_path']

  server_url node['knife']['chef_server_url']
  api_key_path node['knife']['temp_client_key_path']
  api_client_name node['knife']['temp_node_name']
  action :delete
end

# Create the new admin user with random password
knife_user node['knife']['node_name'] do
  password (0...20).map { [*('a'..'z'),*('A'..'Z'),*('0'..'9')].to_a[rand(62)] }.join
  admin true
  output_key_file_path node['knife']['client_key_path']
  
  server_url node['knife']['chef_server_url']
  api_key_path node['knife']['temp_client_key_path']
  api_client_name node['knife']['temp_node_name']
  action :create
end

# Delete the temp user
knife_user node['knife']['temp_node_name'] do
  output_key_file_path node['knife']['temp_client_key_path']

  server_url node['knife']['chef_server_url']
  api_key_path node['knife']['client_key_path']
  api_client_name node['knife']['node_name']
  action :delete
end