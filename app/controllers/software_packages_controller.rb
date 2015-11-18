class SoftwarePackagesController < ApplicationController
  before_action :set_image
  before_action :set_software_package, only: [:show, :edit, :update, :destroy]




  def index
    @software_packages = @image.software.all
  end

  def show
  end


  def new
    @software_package = @image.software.new
  end


  def edit
  end

  def create
    @software_package = @image.software.new(software_package_params)

    respond_to do |format|
      if @software_package.save
        format.html { redirect_to @software_package, notice: 'Software package was successfully updated.' }
        format.js
      else
        format.html  { render :edit }
        format.js
      end
    end


  end

  # PATCH/PUT /software_packages/1
  # PATCH/PUT /software_packages/1.json
  def update
    respond_to do |format|
      if @software_package.update(software_package_params)
        format.html { redirect_to @software_package, notice: 'Software package was successfully updated.' }
        format.json { render :show, status: :ok, location: @software_package }
      else
        format.html { render :edit }
        format.json { render json: @software_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /software_packages/1
  # DELETE /software_packages/1.json
  def destroy
    @software_package.destroy
    respond_to do |format|
      format.html { redirect_to software_packages_url, notice: 'Software package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_software_package
      @software_package = @image.software.find(params[:id])
    end

    def set_image
      @image = Image.find(params[:image_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def software_package_params
      params.require(:software_package).permit(:name, :version, :note, :image_id)
    end
end
