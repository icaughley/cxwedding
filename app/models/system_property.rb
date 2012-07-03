class SystemProperty < ActiveRecord::Base
  attr_accessible :property_key, :property_value

  validates_presence_of :property_key

  # Keys
  DB_SESSION = "SB_SESSION"

  def initialize( key )
    super()
    self.property_key = key
  end

  def self.set!( key, value )
    property = get_property(key) || new( key )
    property.property_value = value
    property.save!
  end

  def self.get( key )
    property = get_property(key)
    if property
      return property.property_value
    else
      return nil
    end
  end

  private

  def self.get_property( key )
    find(:first, :conditions => ["property_key = ?", key])
  end

end
