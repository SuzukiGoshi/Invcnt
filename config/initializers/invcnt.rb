Rails.application.configure do
	config.invcnt = {
		leader: { host: "invcnt.app.com", path: ""},
		admin: { host: "invcnt.app.com", path: "admin"},
		member: { host: "invcnt.app.com", path: "member"}
	}
end
