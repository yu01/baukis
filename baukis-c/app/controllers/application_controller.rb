class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :set_layout

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  include ErrorHandlers if Rails.env.production?

  private

  def set_layout
    if request.path.match  (%r{/(staff|admin|customer)\b})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

  # def set_layout
  #   if params[:controller].match(%r{\A(staff|admin|customer)/})
  #     Regexp.last_match[1]
  #   else
  #     'customer'
  #   end
  # end

  def rescue403(e)
    @exception = e
    render 'errors/forbidden', status: 403
  end

  def rescue404(e)
    @exception = e
    render 'errors/not_found', status: 404
  end

  def rescue500(e)
    @exception = e
    render 'errors/internal_server_error', status: 500
  end
end
