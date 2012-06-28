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
      title = ["Awesome project", "Sweet thang", "Next new doodle",
               "Sleek mockups", "Super duper designs"].sample

      users.each do |user|
        user.projects.create!(title: title)
      end
    end

    # Create revisions
    4.times do |i|
      image = File.open("./app/assets/images/sample_data/sample_v#{i+1}.png")
      users.each do |user|
        r = user.projects.first.revisions.create!(image: image)
        r.feedbacks.create!(author: user.name, comment: "Some awesome feedback.")
      end
    end
  end
end
