require 'open-uri'

class Line < ApplicationRecord

  include Magick

  belongs_to :document

  def create_montage total_lines

    temp_path_one ='./temp_img_one_' + id.to_s + '.png'
    temp_path_two ='./temp_img_two_' + id.to_s + '.png'
    temp_path_three = "temp_" + id.to_s + ".png"

    ########################
    # Get Images
    ########################

    download = open(url_one)
    IO.copy_stream(download, temp_path_one)
    download = open(url_two)
    IO.copy_stream(download, temp_path_two)

    ########################
    # Create file and combine images
    ########################

    new_montage = ImageList.new
    row = ImageList.new

    row.push(Image.read(temp_path_one).first)
    row.push(Image.read(temp_path_one).first)

    new_montage.push (row.append(false))

    picture = new_montage.flatten_images
    file = Tempfile.new(temp_path_three)

    picture.write(file.path)

    ########################
    # Add watercolor
    ########################
    img = Magick::Image.read(temp_path_three).first
    mark = Magick::Image.read("./generic_logo.png").first
    img1 = img.composite(mark, Magick::CenterGravity, Magick::SoftLightCompositeOp)
    img1.write(file.path)

    data = file.read

    self.update!(montage:data)

    file.close
    file.unlink

    File.delete(temp_path_one)
    File.delete(temp_path_two)


    self.document.update!(complete: true) if document.lines.count == total_lines

  end

end
