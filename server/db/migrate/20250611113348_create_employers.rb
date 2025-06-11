class CreateEmployers < ActiveRecord::Migration[8.0]
  def change
    create_table :employers do |t|
      t.string :company_type
      t.string :culture_description
      t.datetime :deleted_at
      t.string :email
      t.integer :live_jobs_count
      t.string :short_description
      t.string :long_description
      t.string :name
      t.integer :page_views
      t.boolean :overtime
      t.integer :paid_jobs_count
      t.integer :size
      t.string :slug
      t.string :website_url
      t.string :country
      t.integer :total_jobs_posted
      t.integer :trial_jobs_count

      t.timestamps
    end
  end
end
