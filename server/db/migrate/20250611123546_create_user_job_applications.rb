class CreateUserJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :user_job_applications do |t|
      t.references :user, index: true, null: false
      t.references :job_application, index: true, null: false

      t.timestamps
    end
  end
end
