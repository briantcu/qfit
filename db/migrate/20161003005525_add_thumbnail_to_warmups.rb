class AddThumbnailToWarmups < ActiveRecord::Migration
  def change
    add_column :warmups, :thumbnail, :string
  end
end
