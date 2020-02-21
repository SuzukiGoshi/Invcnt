class Member::Authenticator
	def initialize(member)
		@member = member
	end

	def authenticate(raw_password)
		@member &&
			@member.hashed_password &&
			@member.start_date <= Date.today &&
			(@member.end_date.nil? || @member.end_date > Date.today) &&
			BCrypt::Password.new(@member.hashed_password) == raw_password
	end
end
