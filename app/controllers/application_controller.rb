class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_ability
    if customer_signed_in?

      @current_ability ||= Ability.new(current_customer)
    else
      
      @current_ability ||= Ability.new(current_user)
    end
  end

  private

  def require_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end
end
