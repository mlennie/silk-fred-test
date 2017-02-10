class DocumentsController < ApplicationController
  def create
    Document.import(params[:file])
    redirect_to root_url, notice: 'Document Imported'
  end

  def index
    @documents = Document.order(created_at: :desc)
  end

  def show
    @document = Document.find(params[:id])

    respond_to do |format|
      format.csv { send_data @document.export }
    end
  end

end
