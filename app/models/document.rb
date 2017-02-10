class Document < ApplicationRecord

  has_many :lines

  def self.import file
    doc = Document.create
    spreadsheet = Roo::Spreadsheet.open(file.path)
    (1..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)

      line_data = {
        document_id: doc.id,
        url_one: row[0],
        url_two: row[1]
      }

      line = Line.create(line_data)
      line.create_montage
    end
  end

end
