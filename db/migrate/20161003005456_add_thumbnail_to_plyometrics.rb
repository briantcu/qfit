class AddThumbnailToPlyometrics < ActiveRecord::Migration
  def change
    add_column :plyometrics, :thumbnail, :string
  end
end
