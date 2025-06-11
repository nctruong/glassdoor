class CreateJobApplications < ActiveRecord::Migration[8.0]
  def change
    create_table :job_applications do |t|
      t.string :email
      t.boolean :email_to_candidate_status
      t.boolean :email_to_employer_status
      t.string :fullname

      t.references :cv, index: true, null: false
      t.references :job, index: true, null: false

      t.timestamps
    end
  end
end
