require "rails_helper"

describe "リーダーによる自分のアカウントの管理", "ログイン前" do
	include_examples "a protected singular leader controller", "leader/inv_members"
end

describe "リーダーによる自分のアカウントの管理" do
	before do
		post leader_session_url,
			params: {
				leader_login_form: {
					inv_id: inv_member.inv_id,
					password: "pw"
			}
		}
	end

	describe "情報表示" do
		let(:inv_member) { create(:inv_member) }

		example "成功" do
			get leader_inv_members_url
			expect(response.status).to eq(200)
		end

		example "停止フラグがセットされたら強制的にログアウト" do
			inv_member.update_column(:suspended, true)
			get leader_inv_members_url
			expect(response).to redirect_to(leader_root_url)
		end

		example "セッションタイムアウト" do
			travel_to Leader::Base::TIMEOUT.from_now.advance(seconds: 1)
			get leader_inv_members_url
			expect(response).to redirect_to(leader_login_url)
		end

	end
end
