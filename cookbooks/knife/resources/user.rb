actions :create, :delete

default_action :create

attribute :username, :name_attribute => true, :kind_of => String, :regex => /.*/, :default => nil

attribute :password, :kind_of => String, :regex => /.*/, :default => nil # at least 6 chars
attribute :admin, :kind_of => [TrueClass, FalseClass], :default => false
attribute :output_key_file_path, :kind_of => String, :regex => /.*/, :default => nil

attribute :server_url, :kind_of => String, :regex => /.*/, :default => nil
attribute :api_key_path, :kind_of => String, :regex => /.*/, :default => nil
attribute :api_client_name, :kind_of => String, :regex => /.*/, :default => nil

attr_accessor :exists