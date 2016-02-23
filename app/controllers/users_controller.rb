class UsersController < ApplicationController

  def show
  end

  def current_user_home
    if current_user && current_user.company.present?
      redirect_to current_user.company
    else
      redirect_to new_company_path
    end
  end
end
