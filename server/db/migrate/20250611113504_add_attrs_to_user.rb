class AddAttrsToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :fullname, :string
    add_column :users, :phone, :string
    add_column :users, :roke_mask, :integer
    add_column :users, :sign_in_count, :integer
    add_column :users, :title, :string
    add_column :users, :viewable_cv, :boolean
    add_column :users, :employer_id, :integer

    add_index :users, :employer_id
  end
end
