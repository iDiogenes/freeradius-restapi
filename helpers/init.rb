require_relative 'headers'
Api.helpers Headers

require_relative 'authentication'
Api.helpers AuthenticationHelper

require_relative 'tools'
Api.helpers ToolsHelper