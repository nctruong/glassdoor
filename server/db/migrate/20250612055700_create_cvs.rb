class CreateCvs < ActiveRecord::Migration[8.0]
  def change
    create_table :cvs do |t|
      t.string :status
      t.string :content
      t.string :skill_tags
      t.string :scanned_job_title
      t.string :scanned_employer_names
      t.string :state

      t.references :applicant, index: true

      t.timestamps
    end
  end
end
