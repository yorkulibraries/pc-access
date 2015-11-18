class SoftwarePackagesController < ApplicationController
  before_action :set_software_package, only: [:show, :edit, :update, :destroy]

  # GET /software_packages
  # GET /software_packages.json
  def index
    @software_packages = SoftwarePackage.all
  end

  # GET /software_packages/1
  # GET /software_packages/1.json
  def show
  end

  # GET /software_packages/new
  def new
    @software_package = SoftwarePackage.new
  end

  # GET /software_packages/1/edit
  def edit
  end

  # POST /software_packages
  # POST /software_packages.json
  def create
    @software_package = SoftwarePackage.new(software_package_params)

    respond_to do |format|
      if @software_package.save
        format.html { redirect_to @software_package, notice: 'Software package was successfully created.' }
        format.json { render :show, status: :created, location: @software_package }
      else
        format.html { render :new }
        format.json { render json: @software_package.errors, status: :unprocessable_entity }
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
      @software_package = SoftwarePackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def software_package_params
      params.require(:software_package).permit(:name, :version, :note, :image_id)
    end
end
