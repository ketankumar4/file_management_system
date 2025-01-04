class CreateFileUploads < ActiveRecord::Migration[7.1]
  def change
    create_table :file_uploads do |t|
      t.string :title
      t.text :description
      t.text :file_uploaded
      t.string :shared_link
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
