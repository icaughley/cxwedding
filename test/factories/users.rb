FactoryGirl.define do
  factory :user do
    sequence(:email) { |i| "email#{i}@user.com" }
    name 'Mr User'
    password 'shhhhh'
    admin false

    factory :user_admin do
      admin true
    end

  end
end

