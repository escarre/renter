class ApartmentsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]

  # GET /apartments
  # GET /apartments.json
  def index
    if user_signed_in?
      @apartments = current_user.apartments.paginate(:page => params[:page], :per_page => 9)
    else
      redirect_to root_path, notice: "Sign in or create an account to view your apartments!"
    end
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
    @photos = @apartment.photos.paginate(:page => params[:page], :per_page => 20)
  end

  # GET /apartments/new
  def new
    if user_signed_in?
      @apartment = current_user.apartments.new
      @photo = @apartment.photos.build
    else
      redirect_to root_path, notice: "Sign up or login to create an apartment."
    end
  end

  # GET /apartments/1/edit
  def edit
    # only allow editing if apartment has not been verified
    if @apartment.code_match == true
      redirect_to apartment_path, notice: "This apartment has already been confirmed. It can no longer be edited."
    end
  end

  # POST /apartments
  # POST /apartments.json
  def create
    # associate aparment with user
    @apartment = current_user.apartments.new(apartment_params)
    # generate verification code
    @apartment.code = Apartment.generate_code
    # set apartment user_id field to current_user
    @apartment.user_id = current_user.id if current_user

    respond_to do |format|
      if @apartment.save
        # upload and save multiple images, if they are there
        if params[:photos]
           params[:photos]['image'].each do |a|
             @photo = @apartment.photos.create!(:image => a, :apartment_id => @apartment.id)
           end
        end
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new, notice: 'Something went wrong. Please try again!' }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        if params[:photos]
            params[:photos]['image'].each do |a|
              @photo = @apartment.photos.create!(:image => a, :apartment_id => @apartment.id)
            end
        end
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # logic for landlord to verify photos with his code
  def confirm_code
    @apartment = Apartment.friendly.find(params[:apartment_id])
    @user = current_user
    respond_to do |format|
      # if landlord input matches the generated code
      if params[:confirm_code] == @code
        # tell the mailer to send confirmation email
        ApartmentMailer.confirmation_email(@user).deliver
        # update code_match field to be true and set match_date to now
        @apartment.update_attributes(:code_match => true, :match_date => DateTime.now)
        format.html { redirect_to @apartment, notice: 'Code accepted. Thank you!' }
      else
        format.html { redirect_to @apartment, notice: 'Incorrect code. Please try again.' }
      end
    end
  end

  def share_apartment
    @apartment = Apartment.friendly.find(params[:apartment_id])
    @user = current_user
    respond_to do |format|
      # tell the mailer to send confirmation email
      ApartmentMailer.verification_email(@user, @apartment).deliver
      format.html { redirect_to @apartment, notice: 'A verification code has been sent to your landlord. Thank you!' }
    end
  end

  # DELETE /apartments/1
  # DELETE /apartments/1.json
  def destroy
    @apartment.destroy
    respond_to do |format|
      format.html { redirect_to apartments_url, notice: 'Apartment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_apartment
      if Apartment.friendly.find(params[:id])
        @apartment = Apartment.friendly.find(params[:id])
      else
        redirect_to root_path, notice: "Sorry, that doesn't exist. Try again!"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:name, :address, :city, :state, :zip, :confirm_code, :landlord_email, :landlord_name, :lease_start, :lease_end, :description, :user_id)
    end
end
