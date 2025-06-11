class CreateJobCandidates < ActiveRecord::Migration[8.0]
  def change
    create_table :job_candidates do |t|
      t.datetime :accepted_at
      t.datetime :invited_at
      t.float :score
      t.string :status
      t.datetime :viewed_at

      t.references :candidate, index: true
      t.references :cv, index: true
      t.references :job, index: true


      t.timestamps
    end
  end
end
