FactoryGirl.define do
  factory :dropbox_image do
    filename 'image1'
    url 'http://dropbox.com/image1'
    expires 1.day.from_now
    thumbnail 'asdfasdf'
  end
end
