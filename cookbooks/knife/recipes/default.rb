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
  gid node['knife']['group']
  system true
  shell "/bin/bash"
  home node['knife']['user_home']
  action :create
end

directory "#{node['knife']['user_home']}/.chef" do
  owner node['knife']['user']
  group node['knife']['group']
  mode '0755'
  recursive true
  action :create
end

template "#{node['knife']['user_home']}/.chef/knife.rb" do
  source 'knife.rb.erb'
  owner node['knife']['user']
  group node['knife']['group']
  mode '0700'
end

