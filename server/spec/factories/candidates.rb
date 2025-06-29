FactoryBot.define do
  factory :candidate do
    city { "MyString" }
    companies { "MyString" }
    email { "MyString" }
    first_applied_date { "2025-06-11 18:41:42" }
    first_approved_date { "2025-06-11 18:41:42" }
    fullname { "MyString" }
    phone_number { "MyString" }
    scanned_email { "MyString" }

    association :cv, factory: :cv
    latest_cv_id { cv.id }
  end
end
