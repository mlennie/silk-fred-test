class Line < ApplicationRecord

  belongs_to :document

  def create_montage total_lines
    document.update(complete: true) if document.lines.count == total_lines
  end

end
