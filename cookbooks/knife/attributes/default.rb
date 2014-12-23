#
# Cookbook Name:: knife
# Attributes:: default
#
# Copyright (C) 2014 Michael Koppen
#
# All rights reserved - Do Not Redistribute
#
default['knife']['user'] = "knife"
default['knife']['group'] = "knife"

default['knife']['log_level'] = "info"
default['knife']['log_location'] = "STDOUT"
default['knife']['node_name'] = node['fqnd']
default['knife']['client_key_path'] = "/etc/chef/client.pem"
default['knife']['validation_client_name'] = "chef-validator"
default['knife']['validation_key'] = "/etc/chef/validation.pem"
default['knife']['chef_server_url'] = "https://localhost:443/"
default['knife']['ssl_verify_mode'] = "verify_peer"
default['knife']['syntax_check_cache_path'] = "/home/#{default['knife']['user']}/.chef/syntax_check_cache"
default['knife']['cookbook_path'] = ""
default['knife']['editor'] = "vi"
