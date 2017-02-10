require 'open-uri'

class Line < ApplicationRecord

  include Magick

  belongs_to :document

  def create_montage total_lines

    download = open(url_one)
    IO.copy_stream(download, './temp_img_one_' + id.to_s + '.png')
    download = open(url_two)
    IO.copy_stream(download, './temp_img_two_' + id.to_s + '.png')

    new_montage = ImageList.new
    row = ImageList.new

    row.push(Image.read('./temp_img_one_' + id.to_s + '.png').first)
    row.push(Image.read('./temp_img_two_' + id.to_s + '.png').first)

    new_montage.push (row.append(false))

    picture = new_montage.flatten_images
    file = Tempfile.new("temp_" + id.to_s + ".jpg")
    picture.write(file.path)

    data = file.read
    self.update!(montage:data)
    file.close
    file.unlink

    self.document.update!(complete: true) if document.lines.count == total_lines
    return true
  end

end
