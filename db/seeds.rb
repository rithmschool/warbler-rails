# set up image data
profile_urls = []
0.upto(100) do |i|
  profile_urls.push "https://randomuser.me/api/portraits/lego/#{i}.jpg" unless i > 9
  profile_urls.push "https://randomuser.me/api/portraits/women/#{i}.jpg"
  profile_urls.push "https://randomuser.me/api/portraits/men/#{i}.jpg"
end

header_image_urls = Array.new(99) do |i|
  HTTParty.get("http://www.splashbase.co/api/v1/images/#{i+1}")['url']
end

# make faker deterministic
Faker::Config.random = Random.new(42)


# destroy all data
User.destroy_all

users = User.create(Array.new(300) do |i|
  {
    email: Faker::Internet.email,
    username: Faker::Internet.user_name,
    image_url: profile_urls[i % profile_urls.length],
    header_image_url: header_image_urls[i % header_image_urls.length],
    bio: Faker::Hipster.paragraph(2),
    location: Faker::Address.city,
    password: 'password'
  }
end
)

puts("Users Created!")

users.each do |user|
  num_messages = Faker::Number.between(1, 5)
  Message.create(Array.new(num_messages) do |i|
    {
      text: Faker::Hipster.paragraph_by_chars(280),
      user_id: user.id,
      created_at: Faker::Date.between(2.years.ago, Date.today)
    }
  end
  )
end

puts("Messages Created!")

users.each do |user|
  num_following = Faker::Number.between(0, 30)
  num_following.times do
    user_index = Faker::Number.unique.between(0, users.length - 1)
    other_user = users[user_index]
    user.follow other_user if other_user.id != user.id
  end
  Faker::Number.unique.clear
end

puts("Relationships Created!")
