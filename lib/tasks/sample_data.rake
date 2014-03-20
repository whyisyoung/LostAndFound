namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create 100 user, the first is admin.
    User.create!(name: "Example User",
                 email: "example@railstutorial.org",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name = Faker::Name.first_name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    # Create 50 lost_items for the first 6 users.
    users = User.all(limit: 6)
    50.times do
      detail = Faker::Lorem.sentence(5)
      users.each do |user|
        user.lost_items.create!(lost_time: DateTime.now,
                                detail: detail,
                                place:  "Library",
                                status: "unclaimed",
                                finder: "Lin",
                                phone:  "18817551234",
                                category_id: 5)
      end
    end

    # Create 6 categories.
    categories = ["electronics", "cards", "belongings", "books", "clothes", "other"]
    categories.each do |category|
      Category.create!(name: category)
    end

  end
end