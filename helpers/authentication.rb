module AuthenticationHelper

  def auth_key?
    if request_headers['x_auth_header'] == APP_CONFIG['AUTHKEY']
      return true
    else
      logger.warn "#{request.ip} - - #{Time.now.utc.strftime("[%d/%b/%Y %H:%M:%S]")} Received request with a bad authentication header"
      logger.warn "#{request.ip} - - #{Time.now.utc.strftime("[%d/%b/%Y %H:%M:%S]")} Received header: #{request_headers}"
      return false
    end
  end

  module_function :auth_key?
end