require "rails_helper"

describe "ルーティング" do
	example "リーダートップページ" do
		config = Rails.application.config.invcnt
		url = "http://#{config[:leader][:host]}/#{config[:leader][:path]}"
		expect(get: url).to route_to(
			host: config[:leader][:host],
			controller: "leader/top",
			action: "index"
		)
	end

	example "管理者ログインフォーム" do
		config = Rails.application.config.invcnt
		url = "http://#{config[:admin][:host]}/#{config[:admin][:path]}/login"
		expect(get: url).to route_to(
			host: config[:admin][:host],
			controller: "admin/sessions",
			action: "new"
		)
	end

	example "メンバートップページ" do
		config = Rails.application.config.invcnt
		url = "http://#{config[:member][:host]}/#{config[:member][:path]}"
		expect(get: url).to route_to(
			host: config[:member][:host],
			controller: "member/top",
			action: "index"
		)
	end

	example "ホスト名が対象外ならroutableではない" do
		expect(get: "http://foo.example.jp").not_to be_routable
	end

	example "存在しないパスならroutabaleではない" do
		config = Rails.application.config.invcnt
		expect(get: "http://#{config[:leader][:host]}/xyz").not_to be_routable
	end
end
