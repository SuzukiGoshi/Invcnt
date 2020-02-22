class Member::InventoriesController < Member::Base
	def index
		@inventories = Inventory.order(:name)
	end

	def show
		inventory = Inventory.find(params[:id])
		redirect_to [:edit, :leader, inventory]
	end

end
