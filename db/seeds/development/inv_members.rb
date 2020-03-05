InvMember.create!(
	inv_id: "port",
	family_name: "ポート",
	given_name: "フォリオ",
	family_name_kana: "ポート",
	given_name_kana: "フォリオ",
	password: "port",
  start_date: Date.today,
	leader: 1
)

family_names = %w{
	佐藤:サトウ:sato
	鈴木:スズキ:suzuki
	高橋:タカハシ:takahashi
	田中:タナカ:tanaka
}

given_names = %w{
	次郎:ジロウ:jiro
	三郎:サブロウ:saburo
	松子:マツコ:matsuko
	竹子:タケコ:takeko
	梅子:ウメコ:umeko
}

20.times do |n|
	fn = family_names[n % 4].split(":")
	gn = given_names[n % 5].split(":")

	InvMember.create!(
		inv_id: "member_#{fn[2]}_#{gn[2]}",
		family_name: fn[0],
		given_name: gn[0],
		family_name_kana: fn[1],
		given_name_kana: gn[1],
		password: "password",
		start_date: (100 - n).days.ago.to_date,
		end_date: n == 0 ? Date.today : nil,
		suspended: n == 1,
		leader: n == 1
	)
	end
