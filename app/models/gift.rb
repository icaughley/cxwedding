class Gift < ActiveRecord::Base
  attr_accessible :description, :location, :title, :value, :image_id

  belongs_to :user
  belongs_to :dropbox_image

  validates_presence_of :description, :location, :title, :value

  validates_numericality_of :value
end
