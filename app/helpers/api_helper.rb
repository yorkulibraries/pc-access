module ApiHelper
  def remote_request?
    request.format == "text/javascript"
  end

  def append_js_ext
    remote_request? ? ".js" : ""
  end

end
