class Api < Sinatra::Application

	get "/radacct/?" do
		content_type :json
		
		radacct = RadAcct
		radacct = build_filters(radacct, params)
		radacct = build_conditions(radacct, params)
		extract_radusers(radacct).to_json
	end
end