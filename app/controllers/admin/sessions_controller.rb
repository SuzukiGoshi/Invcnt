class Admin::SessionsController < Admin::Base
  skip_before_action :authorize
  def new
  	if  current_administrator
  		redirect_to :admin_root
  	else
  		@form = Admin::LoginForm.new
  		render action: "new"
  	end
  end
  def create
  	@form = Admin::LoginForm.new(login_form_params)
  	if @form.inv_id.present?
  		administrator = Administrator.find_by(inv_id: @form.inv_id)
  	end
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      session[:administrator_id] = administrator.inv_id
      session[:admin_last_access_time] = Time.current
      flash.notice = "ログインしました。"
      redirect_to :admin_root
    else
      flash.now.alert = "IDまたはパスワードが正しくありません。"
      render action: "new"
    end
  end

  private def login_form_params
		params.require(:admin_login_form).permit(:inv_id, :password)
	end

  def destroy
		session.delete(:administrator_id)
		flash.notice = "ログアウトしました。"
		redirect_to :admin_root
	end
end
