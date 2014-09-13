class AddTakenAtToPost < ActiveRecord::Migration
  def change
    add_column :posts, :taken_at, :datetime
  end
end
