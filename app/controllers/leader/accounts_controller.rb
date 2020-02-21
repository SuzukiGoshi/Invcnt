class Leader::InvMembersController < Leader::Base
	def index
		@inv_member = InvMember.order(:family_name_kana, :given_name_kana).page(params[:page])
	end
end
