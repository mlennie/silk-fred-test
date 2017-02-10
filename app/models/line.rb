require 'rmagick'

class Line < ApplicationRecord

include Magick

  belongs_to :document

  def create_montage total_lines
    montage = ImageList.new
    row = ImageList.new

    row.push(Image.read(url_one).first)
    row.push(Image.read(url_two).first)

    montage.push (row.append(false))
    montage.append(true).write("montage_" + id + ".jpg")

    document.update(complete: true) if document.lines.count == total_lines
  end

end
