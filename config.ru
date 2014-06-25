require 'yaml'
raw_config = File.read([File.dirname(__FILE__), 'config', 'application.yml'].join('/'))
APP_CONFIG = YAML.load(raw_config)

require ::File.join( ::File.dirname(__FILE__), 'api' )
run Api.new