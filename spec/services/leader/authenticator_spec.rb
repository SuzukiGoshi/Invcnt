require "rails_helper"

describe Leader::Authenticator do
	describe "#authenticate" do
		example "正しいパスワードならtrueを返す" do
			m = build(:inv_member)
			expect(Leader::Authenticator.new(m).authenticate("pw")).to be_truthy
		end

		example "誤ったパスワードならfalseを返す" do
			m = build(:inv_member)
			expect(Leader::Authenticator.new(m).authenticate("xy")).to be_falsey
		end

		example "パスワード未設定ならfalseを返す" do
			m = build(:inv_member, password: nil)
			expect(Leader::Authenticator.new(m).authenticate(nil)).to be_falsey
		end

		example "停止フラグが立っていてもtrueを返す" do
			m = build(:inv_member, suspended: true)
			expect(Leader::Authenticator.new(m).authenticate("pw")).to be_truthy
		end

		example "終了後ならfalseを返す" do
			m = build(:inv_member, end_date: Date.today)
			expect(Leader::Authenticator.new(m).authenticate("pw")).to be_falsey
		end
	end
end
