class Line < ApplicationRecord

  belongs_to :document

  def create_montage
    document.complete.toggle! if document.lines.last == line
  end

end
