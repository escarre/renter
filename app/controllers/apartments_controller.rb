class ApartmentsController < ApplicationController
  before_action :authenticate_user!, only: [:create_code, :edit, :update, :destroy]
  before_action :set_apartment, only: [:show, :edit, :update, :destroy]

  # GET /apartments
  # GET /apartments.json
  def index
    if user_signed_in?
      @apartments = current_user.apartments.all
    else
      redirect_to root_path, notice: "Sign in or create an account to view your apartments!"
    end
  end

  # GET /apartments/1
  # GET /apartments/1.json
  def show
    @photos = @apartment.photos.all
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
  end

  # POST /apartments
  # POST /apartments.json
  def create
    @apartment = current_user.apartments.new(apartment_params)
    @apartment.code = Apartment.generate_code

    respond_to do |format|
      if @apartment.save
        params[:photos]['image'].each do |a|
          @photo = @apartment.photos.create!(:image => a, :apartment_id => @apartment.id)
        end
        format.html { redirect_to @apartment, notice: 'Apartment was successfully created.' }
        format.json { render :show, status: :created, location: @apartment }
      else
        format.html { render :new }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apartments/1
  # PATCH/PUT /apartments/1.json
  def update
    respond_to do |format|
      if @apartment.update(apartment_params)
        params[:photos]['image'].each do |a|
          @photo = @apartment.photos.create!(:image => a, :apartment_id => @apartment.id)
        end
        format.html { redirect_to @apartment, notice: 'Apartment was successfully updated.' }
        format.json { render :show, status: :ok, location: @apartment }
      else
        format.html { render :edit }
        format.json { render json: @apartment.errors, status: :unprocessable_entity }
      end
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
      @apartment = Apartment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def apartment_params
      params.require(:apartment).permit(:name, :address, :lease_start, :lease_end, :description, :user_id)
    end
end
