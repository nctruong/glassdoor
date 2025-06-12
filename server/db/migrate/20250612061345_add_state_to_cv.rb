class AddStateToCv < ActiveRecord::Migration[8.0]
  def change
    remove_column :cvs, :state
    add_column :cvs, :state, :integer
  end
end
