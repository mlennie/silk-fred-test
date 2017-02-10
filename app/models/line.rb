class Line < ApplicationRecord

  belongs_to :document

  def create_montage
    return true
  end

end
