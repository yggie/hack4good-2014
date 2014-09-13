class AddCollectionPeriodToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :start_date, :datetime
    add_column :collections, :end_date, :datetime
  end
end
