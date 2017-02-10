class Document < ApplicationRecord

  has_many :lines

  def self.import file
    doc = Document.create
    spreadsheet = Roo::Spreadsheet.open(file.path)
    rows = spreadsheet.last_row
    (1..rows).each do |i|
      row = spreadsheet.row(i)

      line_data = {
        document_id: doc.id,
        url_one: row[0],
        url_two: row[1]
      }

      line = Line.create(line_data)
      CreateMontageJob.perform_later(line,rows)
    end

  end

  def export(options = {})
    desired_columns = ["url_one", "url_two", "montage_url"]
    CSV.generate(options) do |csv|
      csv << desired_columns
      lines.all.each do |line|
        csv << line.attributes.values_at(*desired_columns)
      end
    end
  end

end
