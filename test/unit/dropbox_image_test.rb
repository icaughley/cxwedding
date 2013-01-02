require 'test_helper'

class DropboxImageTest < ActiveSupport::TestCase
  should validate_presence_of(:filename)
  should validate_presence_of(:thumbnail)

  should have_one(:gift)
end
