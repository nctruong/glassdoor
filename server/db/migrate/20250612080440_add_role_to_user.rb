class AddRoleToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :role, :integer
    remove_column :users, :roke_mask
  end
end
