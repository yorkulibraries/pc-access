class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
      @images = Image.all
    end

    def show
    end

    def new
      @image = Image.new
    end

    def edit
    end

    def create
      @image = Image.new(image_params)
      #@location.is_deleted = false

      respond_to do |format|
        if @image.save
          format.html { redirect_to images_path, notice: 'Image was successfully created.' }
          # format.json { render action: 'show', status: :created, location: @location }
        else
          format.html { render action: 'new' }
          # format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end

    end

    def update
      respond_to do |format|

        if @image.update(image_params)
          format.html { redirect_to images_path, notice: 'Image was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @image.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @image.destroy


      respond_to do |format|
        if @image.save
          format.html { redirect_to locations_path, notice: 'Image was successfully deleted' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @location.errors, status: :unprocessable_entity }
        end
      end
    end


    private
      # Use callbacks to share common setup or constraints between actions.
      def set_image
        @image = Image.find(params[:id])
      end

      def image_params
        params.require(:image).permit( :name, :os_name, :os_version)
      end
end
