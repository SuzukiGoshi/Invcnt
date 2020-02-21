class InvMemberFormPresenter < UserFormPresenter
	def suspended_check_box
		markup(:div, class: "check-boxes") do |m|
			m << check_box(:suspended)
			m << label(:suspended, "アカウント停止")
		end
	end
	def leader_check_box
		markup(:div, class: "check-boxes") do |m|
			m << check_box(:leader)
			m << label(:leader, "リーダー")
		end
	end
end
