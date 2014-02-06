class RadPostAuth < Sequel::Model(:radpostauth)
	def validate
		super
		raise "radpostauth can only be updated by freeRADIUS"
	end
end