class ErrorsController < ApplicationController
  def routing_error
  	raise ApplicationController::RoutingError,
  	  "No route matchs #{request.path.inspect}"
  end
end
