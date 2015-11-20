class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy, :attach_computers_to]

  def index
    if params[:q]
      @images = Image.where("name LIKE ?", "%#{params[:q]}%")
    else
      @images = Image.all
    end

    respond_to  do |format|
      format.html
      format.js { render json: @images.map { |i| [i.id, i.name] } }
    end
  end

  def show
    @computer_list = @image.computers.select(:ip).collect { |c| c.ip }.join("\n")
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
        format.js
      else
        format.html { render action: 'new' }
        format.js
      end
    end

  end

  def update
    respond_to do |format|

      if @image.update(image_params)
        format.html { redirect_to images_path, notice: 'Image was successfully updated.' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
    end
  end

  def destroy
    @image.deleted = true

    respond_to do |format|
      if @image.save
        format.html { redirect_to locations_path, notice: 'Image was successfully deleted' }
        format.js
      else
        format.html { render action: 'edit' }
        format.js
      end
    end
  end

  def attach_computers_to
    list = params[:computer_list]
    @original_list = @image.computers.select(:ip).collect { |c| c.ip }

    @image.attach_computers(list)
    @computers = @image.computers

    @computer_list = @image.computers.select(:ip).collect { |c| c.ip }.join("\n")

    respond_to do |format|
      format.js
      format.html { render nothing: true}
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
