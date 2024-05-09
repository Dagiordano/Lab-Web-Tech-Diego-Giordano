# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'







User.destroy_all

User.create!(name: "John Doe",
email: "juancho@gmail.com",
password: "juancho1234")

4.times do
	User.create(
	name: Faker::JapaneseMedia::FullmetalAlchemistBrotherhood.character,
	email: Faker::Internet.email(domain: 'gmail.com'),
	password: Faker::Internet.password(min_length: 8)
	)

end




Tag.destroy_all

Tag.create!([{
	name: "#feliz"
},
{
	name: "#triste"
},

{
	name: "#chile"
},

{
	name: "#uandes"
},

{
	name: "#barcelona"
}

])


Post.destroy_all

User.all.each do |user|
  2.times do |n|
    post = user.posts.create!(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      published_at: Faker::Time.backward(days: 360, period: :evening),
      answers_count: Faker::Number.between(from: 1, to: 200),
      likes_count: Faker::Number.between(from: 1, to: 200)
    )
    
    rand(1..3).times do
	  post = Post.last
      post.tags << Tag.offset(rand(Tag.count)).first
    end
  end
end