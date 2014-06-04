class ApartmentMailer < ActionMailer::Base
  default from: "renterapplication@gmail.com"
  
  def verification_email(user, apartment)
      @user = user
      @apartment = apartment
      @url  = apartment_path(@apartment)
      mail(to: @apartment.landlord_email, subject: 'Apartment Documentation Request')
  end
  
  def confirmation_email(user, apartment)
    @apartment = apartment
    @user = user
    mail(to: [@user.email, @apartment.landlord_email], subject: 'Apartment is confirmed!')
  end
end
