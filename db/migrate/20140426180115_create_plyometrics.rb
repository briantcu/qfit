class CreatePlyometrics < ActiveRecord::Migration
  def change
    create_table :plyometrics do |t|
      t.string :name
      t.string :video_link
      t.text :recommended

      t.timestamps
    end
  end
end
