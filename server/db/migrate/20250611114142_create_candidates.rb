class CreateCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :candidates do |t|
      t.string :city
      t.string :companies
      t.string :email
      t.datetime :first_applied_date
      t.datetime :first_approved_date
      t.string :fullname
      t.string :phone_number
      t.string :scanned_email
      t.integer :latest_cv_id

      t.timestamps
    end
  end
end
