class Gift < ActiveRecord::Base
  attr_accessible :description, :title, :value, :image_id

  belongs_to :user
  belongs_to :dropbox_image, foreign_key: 'image_id'

  validates_presence_of :description, :title, :value
end
