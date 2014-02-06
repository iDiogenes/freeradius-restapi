class Api < Sinatra::Application

	get "/radcheck/?" do
		content_type :json
		
		radcheck = RadCheck
		radcheck = build_filters(radcheck, params)
		radcheck = build_conditions(radcheck, params)
		extract_radusers(radcheck).to_json
	end

	post "/radcheck" do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadCheck.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radcheck/:id" do
		content_type :json
		
		ensure_payload do |session_hash|
			updated_user = RadCheck[params[:id]].update(session_hash)

			body json(updated_user.to_hash)
		end
	end

	delete "/radcheck/:id" do
		content_type :json
		
		deleted_user = RadCheck[params[:id]].delete
		body json(deleted_user.to_hash)
	end
end