class Leader::SessionsController < Leader::Base
  skip_before_action :authorize
  def new
  	if current_leader
  		redirect_to :leader_root
  	else
  		@form = Leader::LoginForm.new
  		render action: "new"
  	end
  end
  def create
  	@form = Leader::LoginForm.new(login_form_params)
  	if @form.inv_id.present?
  		leader = InvMember.find_by(inv_id: @form.inv_id)
  	end
    if Leader::Authenticator.new(leader).authenticate(@form.password)
      if leader.leader?
        session[:leader_id] = leader.inv_id
        session[:last_access_time] = Time.current
        flash.notice = "ログインしました。"
        redirect_to :leader_root
      else
        flash.now.alert = "リーダー権限がありません。"
        render action: "new"
      end
    else
      flash.now.alert = "メールアドレスまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  private def login_form_params
		params.require(:leader_login_form).permit(:inv_id, :password)
	end

  def destroy
		session.delete(:leader_id)
		flash.notice = "ログアウトしました。"
		redirect_to :leader_root
	end
end
