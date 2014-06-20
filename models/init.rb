require 'sequel'

DB = Sequel.connect(settings.db_url)

require_relative 'radcheck'
require_relative 'radreply'
require_relative 'radpostauth'
require_relative 'radacct'
require_relative 'radgroupcheck'
require_relative 'radgroupreply'
require_relative 'radusergroup'