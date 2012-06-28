FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"

    factory :admin do
      admin true
    end
  end

  factory :project do
    title "Lorem ipsum"
    user
  end

  factory :revision do
    image File.open('./app/assets/images/sample_data/sample_image.png')
    project
  end

  factory :feedback do
    comment "Looking awesome."
    author "Brophia"
    revision
  end
end
