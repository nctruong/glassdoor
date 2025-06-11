class CreateEmployees < ActiveRecord::Migration[8.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :title

      t.references :employer, index: true

      t.timestamps
    end
  end
end
