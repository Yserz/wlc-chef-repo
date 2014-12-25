use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :create  do
  if @current_resource.exists
    Chef::Log.info "#{ @new_resource } already exists - nothing to do."
  else
    converge_by("Create #{ @new_resource }") do
      create_user
    end
  end
end

action :delete  do
  if @current_resource.exists
    converge_by("Delete #{ @new_resource }") do
      delete_user
    end
  else
    Chef::Log.info "#{ @new_resource } does not exists - nothing to do."
  end
end

def load_current_resource
  @current_resource = Chef::Resource::KnifeUser.new(@new_resource.username)
  @current_resource.username(@new_resource.username)
  @current_resource.password(@new_resource.password)
  @current_resource.admin(@new_resource.admin)
  @current_resource.output_key_file_path(@new_resource.output_key_file_path)
  
  @current_resource.server_url(@new_resource.server_url)
  @current_resource.api_key_path(@new_resource.api_key_path)
  @current_resource.api_client_name(@new_resource.api_client_name)

  if username_exists?(@current_resource.username)
    @current_resource.exists = true
  end
end

private

def username_exists?(name)
  cmd = Mixlib::ShellOut.new("knife user show #{name}")
  cmd.run_command
  cmd.error!
  true
rescue Mixlib::ShellOut::ShellCommandFailed
  false
end

def create_user
  if new_resource.output_key_file_path != nil
    execute "touch" do
      command "touch #{new_resource.output_key_file_path}"
    end
  end
  
  cmd = []
  cmd << 'knife user create'  << new_resource.username
  # Global settings
  cmd << '--server-url'       << new_resource.server_url      unless new_resource.server_url.nil?
  cmd << '--key'              << new_resource.api_key_path    unless new_resource.api_key_path.nil?
  cmd << '--user'             << new_resource.api_client_name unless new_resource.api_client_name.nil?
  cmd << '--disable-editing'
  cmd << '--yes'
  # User settings
  cmd << '--admin'            if new_resource.admin
  cmd << '--password'         << new_resource.password
  cmd << '--file'             << new_resource.output_key_file_path
  
  Chef::Log.info "#{ cmd.join(' ') }"
  
  execute "knife user create" do
    command cmd.join(' ')
  end
end

def delete_user
  cmd = []
  cmd << 'knife user delete'  << new_resource.username
  # Global settings
  cmd << '--server-url'       << new_resource.server_url      unless new_resource.server_url.nil?
  cmd << '--key'              << new_resource.api_key_path    unless new_resource.api_key_path.nil?
  cmd << '--user'             << new_resource.api_client_name unless new_resource.api_client_name.nil?
  cmd << '--disable-editing'
  cmd << '--yes'
  
  Chef::Log.info "#{ cmd.join(' ') }"
  
  execute "knife user delete" do
    command cmd.join(' ')
  end
  
  # Also delete the key
  execute "rm #{new_resource.output_key_file_path}" do
    # Don't break if it fails
    returns Array(0..255)
  end
end