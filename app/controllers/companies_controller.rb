class CompaniesController < ApplicationController
  before_action :require_sign_in

  def show
    @company = Company.find params[:id]
  end
end
