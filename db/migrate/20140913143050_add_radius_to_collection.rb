class AddRadiusToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :radius, :float
  end
end
