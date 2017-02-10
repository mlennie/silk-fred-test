class CreateLines < ActiveRecord::Migration[5.0]
  def change
    create_table :lines do |t|
      t.string :url_one
      t.string :url_two
      t.binary :montage
      t.integer :document_id

      t.timestamps
    end
    add_index :lines, :document_id
  end
end
