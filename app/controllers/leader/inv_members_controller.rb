class Leader::InvMembersController < Leader::Base
	def index
		@inv_members = InvMember.order(:family_name_kana, :given_name_kana).page(params[:page])
	end
end
