#
# Cookbook Name:: knife
# Recipe:: default
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#

group node['knife']['group'] do
  action :create
end

user node['knife']['user'] do
  group node['knife']['group']
  system true
  shell "/bin/bash"
  home "/home/#{node['knife']['user']}"
  action :create
end

directory "/home/#{node['wlc-workstation']['user']}/.chef" do
  owner node['wlc-workstation']['user']
  group node['wlc-workstation']['group']
  mode '0755'
  recursive true
  action :create
end

template "/home/#{node['wlc-workstation']['user']}/.chef/knife.rb" do
  source 'knife.rb.erb'
  owner "#{node['wlc-workstation']['user']}"
  group "#{node['wlc-workstation']['group']}"
  mode '0700'
end