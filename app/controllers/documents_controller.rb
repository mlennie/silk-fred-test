class DocumentsController < ApplicationController
  def create
    Document.import(params[:file])
    redirect_to root_url, notice: 'Document Imported'
  end

  def index
    @documents = Document.all
  end
end
