class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.float   :latitude
      t.float   :longitude
      t.string  :email

      t.timestamps
    end
  end
end
