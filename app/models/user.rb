class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :admin
  # attr_accessible :title, :body

  after_find :set_first_to_admin

  has_many :gifts

  scope :admins, where( admin: true )

  MAX_GIFTS = 3

  # The number 1 user is always an admin
  def set_first_to_admin
    self.admin = true if( id == 1 )
  end

  def can_link_more_gifts?
    self.gifts.size < MAX_GIFTS
  end
end
