class RadAcct < Sequel::Model(:radacct)
	def validate
		super
		raise "radacct can only be updated by freeRADIUS"
	end
end