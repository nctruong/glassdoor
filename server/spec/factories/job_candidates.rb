FactoryBot.define do
  factory :job_candidate do
    accepted_at { "2025-06-11 19:30:45" }
    invited_at { "2025-06-11 19:30:45" }
    score { 1.5 }
    status { "MyString" }
    viewed_at { "2025-06-11 19:30:45" }

    association :cv, factory: :cv
    association :job, factory: :job
    association :candidate, factory: :candidate
  end
end
