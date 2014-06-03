class User < ActiveRecord::Base
  # extend friendly_id
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  #has many aparments, destroy apartments if user is destroyed       
  has_many :apartments, dependent: :destroy
  
  #set up friendly_id to get pretty URLS
  friendly_id :name, use: :slugged
  
  # define name to use with friendly_id
  def name
      "#{first_name}+#{last_name}"
  end
end
