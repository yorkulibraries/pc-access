module ImagesHelper

  def os_icon(os_name)
    name = os_name.downcase.delete(' ')
    "#{name}.png"
  end
end
