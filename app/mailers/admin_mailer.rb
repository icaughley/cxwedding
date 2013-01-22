class AdminMailer < ActionMailer::Base
  default from: "Ian@Caughley.id.au"

  URL = "http://graywedding.heroku.com"

  def new_user_email( user )
    @user = user
    mail( to: User.admins.map(&:email), subject: "[CXWedding] A new user has signed up: #{@user.name.titleize}" )
  end

  def gift_linked_email( user, gift )
    @user = user
    @gift = gift
    mail( to: User.admins.map(&:email), subject: "[CXWedding] Gift has been selected" )
  end

  def gift_unlinked_email( user, gift )
    @user = user
    @gift = gift
    mail( to: User.admins.map(&:email), subject: "[CXWedding] Somebody changed their mind" )
  end

end
