class Api < Sinatra::Application
  get "/" do
    json({ message: "freeRADIUS REST API" })
  end

  get '/version' do
    json({ message: "The requested API version is #{env['api_version']}" })
  end

  get '/verifykey', :check => :auth_key? do
    json({ message: APP_CONFIG['AUTHKEY'] })
  end

  # Not Found catch-all
  get "/*" do 
    error 404
  end

  post "/*" do 
    error 404
  end

  put "/*" do 
    error 404
  end

  delete "/*" do 
    error 404
  end
end