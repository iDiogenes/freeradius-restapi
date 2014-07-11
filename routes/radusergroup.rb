class Api < Sinatra::Application

	get "/radusergroup/?", :check => :auth_key? do
		content_type :json
		
		radusergroup = RadUserGroup
		radusergroup = build_filters(radusergroup, params)
		radusergroup = build_conditions(radusergroup, params)
		extract_radusers(radusergroup).to_json
	end

	post "/radusergroup", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadUserGroup.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radusergroup/:id", :check => :auth_key? do
		content_type :json
		
		ensure_payload do |session_hash|
			updated_user = RadUserGroup[params[:id]].update(session_hash)

			body json(updated_user.to_hash)
		end
	end

	delete "/radusergroup/:id", :check => :auth_key? do
		content_type :json
		
		deleted_user = RadUserGroup[params[:id]].delete
		body json(deleted_user.to_hash)
	end
end