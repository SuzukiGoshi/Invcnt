class Leader::InventoriesController < Leader::Base
	def index
		@inventories = Inventory.order(:name)
	end

	def show
		inventory = Inventory.find(params[:id])
		redirect_to [:edit, :leader, inventory]
	end

	def edit
		@inventory = Inventory.find(params[:id])
	end

	def update
		@inventory = Inventory.find(params[:id])
		@inventory.assign_attributes(inventory_params)
		if @inventory.save
			flash.notice = "在庫情報を更新しました。"
			redirect_to :leader_inventories
		else
			render action: "edit"
		end
	end

	private def inventory_params
		params.require(:inventory).permit(:name, :stock, :not_used )
	end

end
