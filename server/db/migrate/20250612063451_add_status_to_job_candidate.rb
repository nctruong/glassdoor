class AddStatusToJobCandidate < ActiveRecord::Migration[8.0]
  def change
    remove_column :job_candidates, :status
    add_column :job_candidates, :status, :integer, default: 0
  end
end
