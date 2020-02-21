class Leader::TopController < Leader::Base
  skip_before_action :authorize
  def index
    if current_leader
      render action: "dashboad"
    else
      render action: "index"
    end
  end
end
