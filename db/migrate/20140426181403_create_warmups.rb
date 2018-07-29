class CreateWarmups < ActiveRecord::Migration
  def change
    create_table :warmups do |t|
      t.string :name
      t.boolean :is_stretch
      t.string :video_link

      t.timestamps
    end
  end
end
