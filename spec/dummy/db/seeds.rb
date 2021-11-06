time = Time.parse('2019-01-01 10:00')
50.times do |i|
  Item.create(
    name: "item_#{i+1}",
    age: (i / 10) * 10,
    created_at: time + i.days,
    updated_at: time + i.days
  )
end
