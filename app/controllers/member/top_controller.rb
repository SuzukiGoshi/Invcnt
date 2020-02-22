class Member::TopController < Member::Base
  skip_before_action :authorize
  def index
    if current_member
      render action: "dashboad"
    else
      render action: "index"
    end
  end
end
