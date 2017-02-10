require 'open-uri'

class Line < ApplicationRecord

  include Magick

  belongs_to :document

  def create_montage total_lines

    download = open(url_one)
    IO.copy_stream(download, './temp_img_one.png')
    download = open(url_two)
    IO.copy_stream(download, './temp_img_two.png')

    new_montage = ImageList.new
    row = ImageList.new

    row.push(Image.read("./temp_img_one.png").first)
    row.push(Image.read("./temp_img_two.png").first)

    new_montage.push (row.append(false))

    picture = new_montage.flatten_images
    file = Tempfile.new("temp_image.jpg")
    picture.write(file.path)

    self.update(montage:file.read)

    document.update(complete: true) if document.lines.count == total_lines
  end

end
