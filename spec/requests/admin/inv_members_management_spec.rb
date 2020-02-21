require "rails_helper"

describe "管理者による職員管理", "ログイン前" do
	include_examples "a protected admin controller", "admin/inv_members"
end

describe "管理者によるメンバー管理" do
	let(:administrator) { create(:administrator) }

	before do
		post admin_session_url,
			params: {
				admin_login_form: {
					inv_id: "goshi",
					password: "ps"
				}
			}
	end

	describe "一覧" do
		example "成功" do
			get admin_inv_members_url
			expect(response.status).to eq(200)
		end
	end

	describe "新規登録" do
		let(:params_hash) { attributes_for(:inv_member) }

		example "メンバー一覧ページにリダイレクト" do
			post admin_inv_members_url, params: { inv_member: params_hash }
			expect(response).to redirect_to(admin_inv_members_url)
		end

		example "例外 ActionController::ParameterMissingが発生" do
			expect { post admin_inv_members_url }.
				to raise_error(ActionController::ParameterMissing)
		end
	end

	describe "更新" do
		let(:inv_member) { create(:inv_member) }
		let(:params_hash) { attributes_for(:inv_member) }

		example "suspendedフラグをセットする" do
			params_hash.merge!(suspended: true)
			patch admin_inv_member_url(inv_member),
				params: { inv_member: params_hash}
			inv_member.reload
			expect(inv_member).to be_suspended
		end

		example "hashed_passwordの値は書き換え不可" do
			params_hash.delete(:password)
			params_hash.merge!(hashed_password: "x")
			expect {
				patch admin_inv_member_url(inv_member),
					params: { inv_member: params_hash }
			}.not_to change { inv_member.hashed_password.to_s }
		end
	end
end
