class Photo < ActiveRecord::Base
  # carrierwave uploader
  mount_uploader :image, ImageUploader
  # photo belongs to apartment
  belongs_to :apartment
  #validations
  validates :apartment, presence: true
end
