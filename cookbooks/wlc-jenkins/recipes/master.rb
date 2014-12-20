#
# Cookbook Name:: wlc-jenkins
# Recipe:: default
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'tar'
include_recipe 'java::default'
include_recipe 'jenkins::master'