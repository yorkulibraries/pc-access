module LayoutHelper

  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end


  def page_header(&block)
    content_for(:page_header) do
      yield block
    end
  end

  def sidebar(&block)
     content_for (:sidebar) do
         yield block
     end
  end

  def link_active_if?(c, a = nil)
    if a != nil
      return "active" if controller.controller_name == c && controller.action_name == a
    else
      return "active" if controller.controller_name == c || c.include?(controller.controller_name)
    end

    return ""
  end
  
end
