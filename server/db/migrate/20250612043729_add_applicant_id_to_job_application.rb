class AddApplicantIdToJobApplication < ActiveRecord::Migration[8.0]
  def change
    add_column :job_applications, :applicant_id, :integer
    add_index :job_applications, :applicant_id
  end
end
