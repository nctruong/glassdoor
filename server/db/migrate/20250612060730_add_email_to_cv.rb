class AddEmailToCv < ActiveRecord::Migration[8.0]
  def change
    add_column :cvs, :email, :string
  end
end
