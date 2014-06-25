require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader'
require 'rack/rest_api_versioning'
require 'json'

class Api < Sinatra::Application
  set :environments, %w{development test production staging}
  use Rack::MethodOverride
  require 'newrelic_rpm'

  configure :development do
    require 'pry'
    register Sinatra::Reloader
  end

  register do
    def check (name)
      condition do
        error 401 unless send(name) == true
      end
    end
  end
  # Set default API version
  use Rack::RestApiVersioning, :default_version => '1'
end


require_relative 'routes/init'
require_relative 'models/init'
require_relative 'helpers/init'