namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Example User",
                         email: "example@fake.org",
                         password: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@fake.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password)
    end

    users = User.all(limit: 5)

    # Create projects
    5.times do
      title = Faker::Lorem.words(3)

      users.each do |user|
        user.projects.create!(title: title)
      end
    end

    # Create revisions
    4.times do |i|
      image = File.open("./app/assets/images/sample_data/sample_v#{i+1}.png")
      users.each do |user|
        user.projects.first.revisions.create!(image: image)
      end
    end
  end
end
