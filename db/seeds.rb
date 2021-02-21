# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
# Create public user
public_user = User.create!(
  name: 'Tester Joe',
  email: 'odinflights@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  bio: Faker::GreekPhilosophers.quote,
  city: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
  school: Faker::University.name,
  occupation: Faker::Job.title,
  workplace: Faker::Company.name,
  hometown: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
  rel_status: Faker::Demographic.marital_status,
  avatar_url: Faker::Avatar.image
)

# Create users with female names
25.times do |i|
  user = User.create!(
    name: "#{Faker::Name.female_first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.free_email,
    password: Faker::Internet.password(min_length: 6),
    bio: Faker::GreekPhilosophers.quote,
    city: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    school: Faker::University.name,
    occupation: Faker::Job.title,
    workplace: Faker::Company.name,
    hometown: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    rel_status: Faker::Demographic.marital_status
  )
  user.avatar.attach(
    io: File.open("app/assets/images/female_users/user#{i + 1}.jpeg"),
    filename: "user#{i + 1}.jpeg"
  )
end

# Create users with male names
25.times do |j|
  user = User.create!(
    name: "#{Faker::Name.male_first_name} #{Faker::Name.last_name}",
    email: Faker::Internet.free_email,
    password: Faker::Internet.password(min_length: 6),
    bio: Faker::GreekPhilosophers.quote,
    city: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    school: Faker::University.name,
    occupation: Faker::Job.title,
    workplace: Faker::Company.name,
    hometown: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    rel_status: Faker::Demographic.marital_status
  )
  user.avatar.attach(
    io: File.open("app/assets/images/male_users/user#{j + 1}.jpeg"),
    filename: "user#{j + 1}.jpeg"
  )
end

# Create friendships for all users
User.find_each do |u|
  rand(1..10).times do
    friend = User.find(User.all_except(u).pluck(:id).sample)
    unless Friendship.exists?(u, friend)
      Friendship.request(u, friend)
      Friendship.accept(u, friend)
    end
  end
end

# Create friend requests for public user
6.times do
  potential_friend = User.find(User.all_except(public_user).pluck(:id).sample)
  Friendship.request(potential_friend, public_user) unless Friendship.exists?(public_user, potential_friend)
end

# Send friend requests to other users
5.times do 
  potential_friend = User.find(User.all_except(public_user).pluck(:id).sample)
  Friendship.request(public_user, potential_friend) unless Friendship.exists?(public_user, potential_friend)
end

# Create Posts for all users
100.times do
  Post.create(
    content: [Faker::Quote.famous_last_words, Faker::Movies::BackToTheFuture.quote,
              Faker::Movies::PrincessBride.quote, Faker::Quotes::Shakespeare.hamlet_quote,
              Faker::GreekPhilosophers.quote, Faker::Lorem.paragraph].sample,
    user_id: User.all.pluck(:id).sample
  )
end

# Add Comments & Likes to Posts
Post.find_each do |post|
  rand(0..8).times do
    comment = post.comments.build(
      content: [Faker::TvShows::RuPaul.quote, Faker::TvShows::MichaelScott.quote,
                Faker::TvShows::SiliconValley.quote, Faker::TvShows::DrWho.quote,
                Faker::Movies::HarryPotter.quote, Faker::Lorem.sentence].sample
    )
    comment.user = User.find(User.all.pluck(:id).sample)
    comment.save!
  end
  rand(0..15).times do
    u = User.find(User.all.pluck(:id).sample)
    next if Like.where(user_id: u.id, likeable_id: post.id, likeable_type: 'Post').exists?

    like = post.likes.build(user_id: u.id, likeable_id: post.id, likeable_type: 'Post')
    like.user = u
    like.save!
  end
end

# Add Comments and Likes to Comments
Comment.find_each do |pcom|
  rand(0..3).times do
    comment = pcom.comments.build(
      content: [Faker::TvShows::RuPaul.quote, Faker::TvShows::MichaelScott.quote,
                Faker::TvShows::SiliconValley.quote, Faker::TvShows::DrWho.quote,
                Faker::Movies::HarryPotter.quote, Faker::Lorem.sentence].sample
    )
    comment.user = User.find(User.all.pluck(:id).sample)
    comment.save!
  end
  rand(0..8).times do
    u = User.find(User.all.pluck(:id).sample)
    next if Like.where(user_id: u.id, likeable_id: pcom.id, likeable_type: 'Comment').exists?

    like = pcom.likes.build(user_id: u.id, likeable_id: pcom.id, likeable_type: 'Comment')
    like.user = u
    like.save!
  end
end

# Add Pictures to Random Posts
20.times do |i|
  post = Post.find(Post.all.pluck(:id).sample)
  next if post.image.attached?

  post.image.attach(
    io: File.open("app/assets/images/post_image/photo#{i + 1}.jpg"),
    filename: "photo#{i}.jpg"
  )
  post.save!
end
