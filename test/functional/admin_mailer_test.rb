require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase

  setup do
    @gift = FactoryGirl.create(:gift)
    @user = FactoryGirl.create(:user)
    @admin = FactoryGirl.create(:user, {admin: true})
  end

  test "should send gift linked email to all admins" do
    email = AdminMailer.gift_linked_email( @user, @gift ).deliver
    do_asserts email
  end

  test "should send gift unlinked email to all admins" do
    email = AdminMailer.gift_unlinked_email( @user, @gift ).deliver
    do_asserts email
  end

  private

  def do_asserts( email )
    assert !ActionMailer::Base.deliveries.empty?
    assert_equal [@admin.email], email.to
    assert_match(/#{@user.name.titleize}/, email.encoded )
    assert_match(/#{@gift.title}/, email.encoded )
    assert_match(/graywedding.heroku.com/, email.encoded )
  end

end
