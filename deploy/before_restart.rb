require 'yaml'
Chef::Log.info("running deploy/before_restart.rb")

node[:deploy].each do |application, deploy|
  yml = YAML::dump(deploy[:sinatra_config])
  clean_yml = yml.sub('!', '#')
  IO.write("#{deploy[:current_path]}/config/application.yml", clean_yml)
end