class DropboxImage < ActiveRecord::Base
  attr_accessible :expires, :filename, :thumbnail, :url
  validates_presence_of :filename, :thumbnail

  has_one :gift, foreign_key: 'image_id'

  def expired?
    self.expires.nil? || self.expires < Time.now.utc
  end

end
