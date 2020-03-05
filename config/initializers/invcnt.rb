Rails.application.configure do
	config.invcnt = {
		leader: { host: "goshi2020.herokuapp.com", path: ""},
		admin: { host: "goshi2020.herokuapp.com", path: "admin"},
		member: { host: "goshi2020.herokuapp.com", path: "member"}
	}
end
