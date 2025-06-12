FactoryBot.define do
  factory :applicant do
    cv_level { "MyString" }
    email { "MyString" }
    last_applied_date { "2025-06-11 18:39:29" }
    latest_status { "MyString" }

    association :user, factory: :user
  end
end
