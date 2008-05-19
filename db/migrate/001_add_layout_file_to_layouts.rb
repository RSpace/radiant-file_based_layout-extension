class AddLayoutFileToLayouts < ActiveRecord::Migration
  
  def self.up
    add_column :layouts, :layout_file, :string
  end

  def self.down
    remove_column :layouts, :layout_file
  end
  
end
