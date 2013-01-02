FactoryGirl.define do
  factory :user do
    email 'email@user.com'
    name 'Mr User'
    admin false

    factory :user_admin do
      admin true
    end

  end
end

