class CompaniesController < ApplicationController

  before_action :require_sign_in

  def show
    authorize! :read, @company
    @events = @company.events
  end

  private

  def set_company
    @company = Company.find params[:id]
  end
end
