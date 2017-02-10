class MontagesController < ApplicationController
  def show
    line = Line.find(params[:id])
    send_data line.montage
  end
end
