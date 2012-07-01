class Gift < ActiveRecord::Base
  attr_accessible :description, :location, :title, :value

  belongs_to :user

  validates_presence_of :description, :location, :title, :value

  validates_numericality_of :value
end
