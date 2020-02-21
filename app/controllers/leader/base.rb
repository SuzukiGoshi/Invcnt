class Leader::Base < ApplicationController
	before_action :authorize
	before_action :check_account
	before_action :check_timeout

	private def current_leader
		if session[:leader_id]
			@current_leader ||=
				InvMember.find_by(inv_id: session[:leader_id])
		end
	end

	helper_method :current_leader

	private def authorize
		unless current_leader
			flash.alert = "リーダーとしてログインしてください。"
			redirect_to :leader_login
		end
	end

	private def check_account
		if current_leader && current_leader.suspended?
			session.delete(:leader_id)
			flash.alert = "アカウントが無効になりました。"
			redirect_to :leader_root
		end
	end

	TIMEOUT = 60.minutes

	private def check_timeout
		if current_leader
			if session[:last_access_time] >= TIMEOUT.ago
				session[:last_access_time] = Time.current
			else
				session.delete(:leader_id)
				flash.alert = "セッションがタイムアウトしました。"
				redirect_to :leader_login
			end
		end
	end
end
