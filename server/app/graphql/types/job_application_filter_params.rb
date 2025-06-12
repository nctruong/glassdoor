module Types
  class JobApplicationFilterParams < Types::BaseInputObject
    argument :scope, String, required: false, default_value: 'all'
    argument :page_index, Int, required: false, default_value: 1
    argument :page_size, Int, required: false, default_value: 20
    argument :employer_id, String, required: false, default_value: nil
    argument :job_id, String, required: false, default_value: nil
    argument :sort_field, String, required: false, default_value: :created_at
    argument :sort_direction, String, required: false, default_value: :desc
  end
end
