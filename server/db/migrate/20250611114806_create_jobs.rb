class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :address
      t.string :description
      t.integer :credit_type
      t.string :employer_short_description
      t.string :employer_long_description
      t.string :employer_culture_description
      t.string :employer_email
      t.datetime :expired_at
      t.integer :job_applications_count
      t.datetime :published_at
      t.string :question
      t.string :salary
      t.string :slug
      t.string :title
      t.string :status

      t.references :employer, index: true

      t.timestamps
    end
  end
end
