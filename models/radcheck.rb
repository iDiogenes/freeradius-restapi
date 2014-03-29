class RadCheck < Sequel::Model(:radcheck)
	plugin :validation_helpers
	def validate
		super
		validates_presence([:username, :attribute, :value])
		validates_unique(:username)
	end
end