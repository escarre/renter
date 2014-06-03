module PhotosHelper
  def apt_verified?
    if @photo.apartment.code_match == true
      return true
    else
      return false
    end
  end
end
