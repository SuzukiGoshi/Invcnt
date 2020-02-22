class Member::Base < ApplicationController
	before_action :authorize
	before_action :check_account
	before_action :check_timeout

	private def current_member
		if session[:member_id]
			@current_member ||=
				InvMember.find_by(inv_id: session[:member_id])
		end
	end

	private def authorize
		unless current_member
			flash.alert = "メンバーとしてログインしてください。"
			redirect_to :member_login
		end
	end
	helper_method :current_member


	private def check_account
		if current_member && current_member.suspended?
			session.delete(:member_id)
			flash.alert = "アカウントが無効になりました。"
			redirect_to :member_root
		end
	end

	TIMEOUT = 60.minutes

	private def check_timeout
		if current_member
			if session[:last_access_time] >= TIMEOUT.ago
				session[:last_access_time] = Time.current
			else
				session.delete(:member_id)
				flash.alert = "セッションがタイムアウトしました。"
				redirect_to :member_login
			end
		end
	end
end
