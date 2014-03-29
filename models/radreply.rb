class RadReply < Sequel::Model(:radreply)
	plugin :validation_helpers
	def validate
		super
		validates_presence([:username, :attribute, :value])
		validates_unique([:username, :attribute])
	end
end