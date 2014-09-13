class RemoveCollectionIdFromPost < ActiveRecord::Migration
  def change
    remove_column :posts, :collection_id
  end
end
