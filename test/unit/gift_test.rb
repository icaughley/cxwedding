require 'test_helper'

class GiftTest < ActiveSupport::TestCase
  should validate_presence_of(:description)
  should validate_presence_of(:title)
  should validate_presence_of(:value)

  should belong_to(:user)
  should belong_to(:dropbox_image)
end
