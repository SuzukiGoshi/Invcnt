class Admin::InvMembersController < Admin::Base
	def index
		@inv_members = InvMember.order(:family_name_kana, :given_name_kana).page(params[:page])
	end

	def show
		inv_member = InvMember.find(params[:id])
		redirect_to [ :edit, :admin, inv_member ]
	end

	def new
		@inv_member = InvMember.new
	end

	def edit
		@inv_member = InvMember.find(params[:id])
	end

	def create
		@inv_member = InvMember.new(inv_member_params)
		if @inv_member.save
			flash.notice = "メンバーアカウントを新規登録しました。"
			redirect_to :admin_inv_members
		else
			render action: "new"
		end
	end

	def update
		@inv_member = InvMember.find(params[:id])
		@inv_member.assign_attributes(inv_member_params)
		if @inv_member.save
			flash.notice = "メンバーアカウントを更新しました。"
			redirect_to :admin_inv_members
		else
			render action: "edit"
		end
	end

	private def inv_member_params
		params.require(:inv_member).permit(
			:inv_id, :password, :family_name, :given_name,
			:family_name_kana, :given_name_kana,
			:start_date, :end_date, :suspended,:leader
		)
	end

	def destroy
		@inv_member = InvMember.find(params[:id])
		@inv_member.destroy!
		flash.notice = "メンバーアカウントを削除しました。"
		redirect_to :admin_inv_members
	end
end
