class Api < Sinatra::Application
	# The client needs to send username, password, password_type and all reply attributes and values.
	# JSON example: {"password_type" : "SHA-Password", "username" : "spguser", "Session-Timeout" : "120",  
	# "Maximum-Data-Rate-Downstream" : "150", "Maximum-Data-Rate-Upstream" : "170", "password" : "myencpytedpassword"}
	post "/raduser" do
		content_type :json

		ensure_payload do |session_hash|
			begin
				mod_session_hash = session_hash.clone
				username = mod_session_hash.delete("username")
				password = mod_session_hash.delete("password")
				password_type = mod_session_hash.delete("password_type")
				rad_check_reply = RadCheck.create(username: username, value: password, attribute: password_type, op: ":=")
				
				mod_session_hash.each do |attribute, value|
					RadReply.create(username: username, attribute: attribute, value: value, op: ":=")
				end
				
				status 200
				body json(status: "Success")
			rescue => e
				logger.info e
				status 500
				body json(status: "Raduser creation Failed!")				
			end
		end
	end

	delete "/raduser/:username" do
		content_type :json

		deleted_radcheck_user = RadCheck.where(username: params[:username]).delete
		deleted_radreply_user = RadReply.where(username: params[:username]).delete
		status 204
		body ''
	end
end