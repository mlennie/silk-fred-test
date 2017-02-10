class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
