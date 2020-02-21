FactoryBot.define do
	factory :administrator do
		sequence(:inv_id) { |n| "member#{n}" }
		password { "pw" }
		suspended { false }
	end
end
