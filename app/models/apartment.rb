class Apartment < ActiveRecord::Base
  has_many :photos, dependent: :destroy
  has_one :verification_code
  accepts_nested_attributes_for :photos
  
  def self.generate_code(size=16)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
 string = (0...16).map { o[rand(o.length)] }.join
  end
  
end
