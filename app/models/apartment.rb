class Apartment < ActiveRecord::Base
  # photos belong to apartment, if aparment destroyed photos are as well
  has_many :photos, dependent: :destroy
  # each apartment has one 16 digit verification code
  has_one :verification_code
  #enable nested attributes for photos so can add photos on apartment form
  accepts_nested_attributes_for :photos
  
  # generate random 16 digit verification code
  def self.generate_code(size=16)
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
 string = (0...16).map { o[rand(o.length)] }.join
  end
  
  def paginated_images(page, per_page = 1)
      photos.paginate(page: page, per_page: per_page)
  end
  
end
