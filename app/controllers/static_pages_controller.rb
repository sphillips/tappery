class StaticPagesController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def home  	
  	render layout: 'application'
  end

  def about
  	render layout: 'application'
  end



end
