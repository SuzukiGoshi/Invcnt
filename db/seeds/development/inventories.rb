Inventory.create!(
	name: "胡椒",
	stock: 1
)
names = %w{
	小麦粉
	バター
	砂糖
	塩
	トマト
	ベーキングパウダー
	ブルーベリー
	ラズベリー
	チーズ
	牛乳
	レタス
}
11.times do |n|
Inventory.create!(
	name: names[n],
	stock: 1
)
end
