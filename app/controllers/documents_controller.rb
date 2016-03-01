class DocumentsController < ApplicationController
  before_action :require_sign_in
  before_action :set_company, only: [:new, :create, :show, :index, :download]
  before_action :set_document, only: [:show, :download]

  def index
    @documents = @company.documents
  end

  def show
    # send_data Paperclip.io_adapters.for(@document.file).read
  end

  def new
    @document = Document.new
  end

  def create
    @company = Company.find params[:company_id]
    @document = @company.documents.new( document_params )

    if @document.save
      redirect_to company_path(@company, tab: "docs"), notice: "File successfully uploaded."
    else
      render :new, alert: "Something went wrong."
    end
  end



  def download
    send_file(Paperclip.io_adapters.for(@document.file).path, type: @document.file_content_type, disposition: "attachment", filename: @document.file_name)
    render :show
  end


  private

  def document_params
    params.require(:document).permit(:file, :title, :description)
  end

  def set_document
    @document = Document.find params[:id]
  end

  def set_company
    @company = Company.find params[:company_id]
  end

  def set_company
    @company = Company.find params[:company_id]
  end
end
