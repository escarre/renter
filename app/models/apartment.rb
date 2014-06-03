class Apartment < ActiveRecord::Base
  # extend friendly_id
  extend FriendlyId
  # photos belong to apartment, if aparment destroyed photos are as well
  has_many :photos, dependent: :destroy
  # each apartment has one 16 digit verification code
  has_one :verification_code
  #enable nested attributes for photos so can add photos on apartment form
  accepts_nested_attributes_for :photos
  
  friendly_id :address_url, use: :slugged
  
  def address_url
      "#{address}+#{city}"
  end
  
  # generate random 16 digit verification code
  def self.generate_code(size=16)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
 string = (0...16).map { o[rand(o.length)] }.join
  end

end
