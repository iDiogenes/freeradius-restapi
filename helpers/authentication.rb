module AuthenticationHelper
	
	def auth_key?
	  if request_headers['auth_key'] == ENV['AUTHKEY']
			return true
	  else
	  	logger.warn "#{request.ip} - - #{Time.now.utc.strftime("[%d/%b/%Y %H:%M:%S]")} Received POST request with a bad authentication header"
			return false
	  end
	end
	
	module_function :auth_key?
end