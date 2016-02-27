class DocumentsController < ApplicationController
  before_action :set_company, only: [:new, :create]

  def new
    @document = Document.new
  end

  def create
    @company = Company.find params[:company_id]
    @document = @company.documents.new( document_params )

    if @document.save
      redirect_to @company, notice: "File successfully uploaded."
    else
      render :new, alert: "Something went wrong."
    end
  end

  private

  def document_params
    params.require(:document).permit(:file, :title, :description)
  end

  def set_company
    @company = Company.find params[:company_id]
  end
end
