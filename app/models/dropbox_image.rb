class DropboxImage < ActiveRecord::Base
  attr_accessible :expires, :filename, :thumbnail, :url
  validates_presence_of :filename, :thumbnail

  has_one :gift

  def expired?
    self.expires.nil? || self.expires < Time.now.utc
  end

end
