FactoryBot.define do
	factory :inv_member do
		sequence(:inv_id) { |n| "member#{n}" }
		family_name { "山田" }
		given_name { "太郎" }
		family_name_kana { "ヤマダ" }
		given_name_kana { "タロウ" }
		password { "pw" }
		start_date { Date.yesterday }
		end_date { nil }
		suspended { false }
		leader { false }
	end
end
