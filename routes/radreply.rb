class Api < Sinatra::Application

	get "/radreply/?" do
		content_type :json
		
		radreply = RadReply
		radreply = build_filters(radreply, params)
		radreply = build_conditions(radreply, params)
		extract_radusers(radreply).to_json
	end

	post "/radreply" do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadReply.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radreply/:id" do
		content_type :json
		
		ensure_payload do |session_hash|
			updated_user = RadReply[params[:id]].update(session_hash)

			body json(updated_user.to_hash)
		end
	end

	delete "/radreply/:id" do
		content_type :json
		
		deleted_user = RadReply[params[:id]].delete
		body json(deleted_user.to_hash)
	end
end