#
# Cookbook Name:: wlc-chef-server
# Recipe:: upload
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'wlc-chef-server::default'

git node['wlc-chef-server']['repo_path_local'] do
  repository node['wlc-chef-server']['repo_url']
  action :sync
  notifies :run, "execute[upload_to_chef_server]", :immediately
end

execute "upload_to_chef_server" do
  command "knife upload /"
  cwd node['wlc-chef-server']['repo_path_local']
end