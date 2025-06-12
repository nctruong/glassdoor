class AddStatusToCv < ActiveRecord::Migration[8.0]
  def change
    remove_column :cvs, :status
    add_column :cvs, :status, :integer
  end
end
