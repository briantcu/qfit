class AddIsTemplateToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :is_template, :boolean, default: false
  end
end
