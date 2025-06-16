class Types::JobFilterParams < Types::BaseInputObject
  argument :sort_field, String, required: false
  argument :sort_direction, String, required: false
  argument :employerId, String, required: false
  argument :title, String, required: false
end
