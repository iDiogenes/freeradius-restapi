class Api < Sinatra::Application

	get "/radcheck/?", :check => :auth_key? do
		content_type :json

		radcheck = RadCheck
		radcheck = build_filters(radcheck, params)
		radcheck = build_conditions(radcheck, params)
		extract_radusers(radcheck).to_json
	end

	# The client needs to send username, attribute (password encryption) & password as value (if encrypted pre-encrypt)
	# JSON example: {"attribute" : "SHA-Password", "username" : "boblong", "value" : "myencpytedpassword"}
	post "/radcheck", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			session_hash["op"] = ":="
			new_user = RadCheck.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radcheck/:username", :check => :auth_key? do
		content_type :json
		
		ensure_payload do |session_hash|
			updated_user = RadCheck.where(username: params[:username]).update(session_hash)

			if updated_user == 1
				status 200
				body json(status: "Success")
			elsif updated_user == 0
				status 400
				body json(status: "Bad syntax or record not found")
			end
		end
	end

	delete "/radcheck/:username", :check => :auth_key? do
		content_type :json

		deleted_user = RadCheck.where(username: params[:username]).delete
		status 204
		body ''
	end
end