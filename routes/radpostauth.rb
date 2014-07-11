class Api < Sinatra::Application

	get "/radpostauth/?", :check => :auth_key? do
		content_type :json
		
		radpostauth = RadPostAuth
		radpostauth = build_filters(radpostauth, params)
		radpostauth = build_conditions(radpostauth, params)
		extract_radusers(radpostauth).to_json
	end
end