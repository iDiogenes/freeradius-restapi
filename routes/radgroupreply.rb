class Api < Sinatra::Application

	get "/radgroupreply/?" do
		content_type :json
		
		radgroupreply = RadGroupReply
		radgroupreply = build_filters(radgroupreply, params)
		radgroupreply = build_conditions(radgroupreply, params)
		extract_radusers(radgroupreply).to_json
	end

	post "/radgroupreply" do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadGroupReply.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radgroupreply/:id" do
		content_type :json
		
		ensure_payload do |session_hash|
			updated_user = RadGroupReply[params[:id]].update(session_hash)

			body json(updated_user.to_hash)
		end
	end

	delete "/radgroupreply/:id" do
		content_type :json
		
		deleted_user = RadGroupReply[params[:id]].delete
		body json(deleted_user.to_hash)
	end
end