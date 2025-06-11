FactoryBot.define do
  factory :job_application do
    email { "MyString" }
    email_to_candidate_status { false }
    email_to_employer_status { false }
    fullname { "MyString" }
  end
end
