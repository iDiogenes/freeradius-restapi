class Api < Sinatra::Application

	#open
	get "/radreply/?", :check => :auth_key? do
		content_type :json

		radreply = RadReply
		radreply = build_filters(radreply, params)
		radreply = build_conditions(radreply, params)
		extract_radusers(radreply).to_json
	end

	post "/radreply", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadReply.create(session_hash)

			body json(new_user.to_hash)
		end
	end

	put "/radreply/:id", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			updated_user = RadReply[params[:id]].update(session_hash)

			body json(updated_user.to_hash)
		end
	end

	delete "/radreply/:id", :check => :auth_key? do
		content_type :json

		deleted_user = RadReply[params[:id]].delete
		body json(deleted_user.to_hash)
	end

	#session_time
	post "/radreply/:username/session_timeout", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadReply.create(username: params[:username], attribute: "Session-Timeout", op: ":=", value: session_hash["value"])

			body json(new_user.to_hash)
		end
	end

	put "/radreply/:username/session_timeout", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			updated_user = RadReply.where(username: params[:username], attribute: "Session-Timeout").update(value: session_hash["value"])
			if updated_user == 1
				status 200
				body json(status: "Success")
			elsif updated_user == 0
				status 400
				body json(status: "Bad syntax or record not found")
			end
		end
	end

	delete "/radreply/:username/session_timeout", :check => :auth_key? do
		content_type :json

		deleted_user = RadReply.where(username: params[:username], attribute: "Session-Timeout").delete
		status 204
		body ''
	end

	#maximum_data_rate_upstream
	post "/radreply/:username/maximum_data_rate_upstream", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadReply.create(username: params[:username], attribute: "Maximum-Data-Rate-Upstream", op: ":=", value: session_hash["value"])

			body json(new_user.to_hash)
		end
	end

	put "/radreply/:username/maximum_data_rate_upstream", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			updated_user = RadReply.where(username: params[:username], attribute: "Maximum-Data-Rate-Upstream").update(value: session_hash["value"])
			if updated_user == 1
				status 200
				body json(status: "Success")
			elsif updated_user == 0
				status 400
				body json(status: "Bad syntax or record not found")
			end
		end
	end

	delete "/radreply/:username/maximum_data_rate_upstream", :check => :auth_key? do
		content_type :json

		deleted_user = RadReply.where(username: params[:username], attribute: "Maximum-Data-Rate-Upstream").delete
		status 204
		body ''
	end

	#maximum_data_rate_downstream
	post "/radreply/:username/maximum_data_rate_downstream", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			new_user = RadReply.create(username: params[:username], attribute: "Maximum-Data-Rate-Downstream", op: ":=", value: session_hash["value"])

			body json(new_user.to_hash)
		end
	end

	put "/radreply/:username/maximum_data_rate_downstream", :check => :auth_key? do
		content_type :json

		ensure_payload do |session_hash|
			updated_user = RadReply.where(username: params[:username], attribute: "Maximum-Data-Rate-Downstream").update(value: session_hash["value"])
			if updated_user == 1
				status 200
				body json(status: "Success")
			elsif updated_user == 0
				status 400
				body json(status: "Bad syntax or record not found")
			end
		end
	end

	delete "/radreply/:username/maximum_data_rate_downstream", :check => :auth_key? do
		content_type :json

		deleted_user = RadReply.where(username: params[:username], attribute: "Maximum-Data-Rate-Downstream").delete
		status 204
		body ''
	end
end