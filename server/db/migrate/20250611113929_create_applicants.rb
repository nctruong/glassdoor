class CreateApplicants < ActiveRecord::Migration[8.0]
  def change
    create_table :applicants do |t|
      t.string :cv_level
      t.string :email
      t.datetime :last_applied_date
      t.string :latest_status
      t.references :user, index: true

      t.timestamps
    end
  end
end
