class CompaniesController < ApplicationController
  before_action :set_company

  def show
    authorize! :read, @company
    @events = @company.events if @company
  end

  private

  def set_company
    @company = Company.find params[:id]
  end
end
