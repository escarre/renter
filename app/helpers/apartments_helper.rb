module ApartmentsHelper
  def verified?
    if @apartment.code_match == true && @apartment.code != nil
      return true
    else
      return false
    end
  end
end
