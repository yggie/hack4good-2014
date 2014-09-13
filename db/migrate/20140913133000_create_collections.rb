class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string    :title
      t.text      :criteria
      t.float     :latitude
      t.float     :longitude

      t.timestamps
    end
  end
end
