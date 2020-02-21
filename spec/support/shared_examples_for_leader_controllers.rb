shared_examples "a protected leader controller" do |controller|
	let(:args) do
		{
			host: Rails.application.config.invcnt[:leader][:host],
			controller: controller
		}
	end

	describe "#index" do
		example "ログインフォームにリダイレクト" do
			get url_for(args.merge(action: :index))
			expect(response).to redirect_to(leader_login_url)
		end
	end

	describe "#show" do
		example "ログインフォームにリダイレクト" do
			get url_for(args.merge(action: :show, id: 1))
			expect(response).to redirect_to(leader_login_url)
		end
	end
end

shared_examples "a protected singular leader controller" do |controller|
	let(:args) do
		{
			host: Rails.application.config.invcnt[:leader][:host],
			controller: controller
		}
	end

	describe "#show" do
		example "ログインフォームにリダイレクト" do
			get url_for(args.merge(action: :show))
			expect(response).to redirect_to(leader_login_url)
		end
	end
end
