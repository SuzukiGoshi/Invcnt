class Leader::Authenticator
	def initialize(leader_member)
		@leader_member = leader_member
	end

	def authenticate(raw_password)
		@leader_member &&
			@leader_member.hashed_password &&
			@leader_member.start_date <= Date.today &&
			(@leader_member.end_date.nil? || @leader_member.end_date > Date.today) &&
			BCrypt::Password.new(@leader_member.hashed_password) == raw_password
	end
end
