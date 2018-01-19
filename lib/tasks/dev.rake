namespace :dev do
  task fake_user: :environment do
    
    20.times do |t|
      User.create!(
        name: FFaker::Name.name,
        email: FFaker::Internet.email,
        password: "testuser"
      )
    end

    puts "Created fake users"
    puts "Now you have #{User.count} users data"
  end

  task fake_restaurant: :environment do
    
    Restaurant.destroy_all

    500.times do |t|
      Restaurant.create!(
        name: FFaker::Name.first_name,
        opening_hours: FFaker::Time.datetime,
        tel: FFaker::PhoneNumber.short_phone_number,
        address: FFaker::Address.street_address,
        description: FFaker::Lorem.paragraph,
        category: Category.all.sample
      )
    end

    puts "Created fake restaurants"
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_comment: :environment do

    Comment.delete_all

    user = User.all.drop_while{ |user| user.role == "admin" }

    Restaurant.all.each do |restaurant|
      rand(3...5).times do |t|
        restaurant.comments.create(
          content: FFaker::Lorem.sentence,
          restaurant: restaurant,
          user: user.sample
        )
      end
    end

    puts "Created fake comments"
    puts "now you have #{Comment.count} comments data"
  end

  task fill_user_data: :environment do
    User.all.each do |user|

      if user.role != "admin"
        user.name = FFaker::Name.name
        user.intro = FFaker::LoremFR.phrase
        user.save
      end

      puts user.email
      puts user.name
      puts user.intro
      puts
    end
  end
end