class Member::SessionsController < Member::Base
  skip_before_action :authorize
  def new
  	if current_member
  		redirect_to :member_root
  	else
  		@form = Member::LoginForm.new
  		render action: "new"
  	end
  end
  def create
  	@form = Member::LoginForm.new(login_form_params)
  	if @form.inv_id.present?
  		member = InvMember.find_by(inv_id: @form.inv_id)
  	end
    if Member::Authenticator.new(member).authenticate(@form.password)
      session[:member_id] = member.inv_id
      session[:last_access_time] = Time.current
      flash.notice = "ログインしました。"
      redirect_to :member_root
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  private def login_form_params
		params.require(:member_login_form).permit(:inv_id, :password)
	end

  def destroy
		session.delete(:member_id)
		flash.notice = "ログアウトしました。"
		redirect_to :member_root
	end
end
