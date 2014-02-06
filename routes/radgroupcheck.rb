class Api < Sinatra::Application

	get "/radgroupcheck/?" do
		content_type :json
		
		radgroupcheck = RadGroupCheck
		radgroupcheck = build_filters(radgroupcheck, params)
		radgroupcheck = build_conditions(radgroupcheck, params)
		extract_radusers(radgroupcheck).to_json
	end

	post "/radgroupcheck" do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadGroupCheck.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radgroupcheck/:id" do
		content_type :json
		
		ensure_payload do |session_hash|
			updated_user = RadGroupCheck[params[:id]].update(session_hash)

			body json(updated_user.to_hash)
		end
	end

	delete "/radgroupcheck/:id" do
		content_type :json
		
		deleted_user = RadGroupCheck[params[:id]].delete
		body json(deleted_user.to_hash)
	end
end