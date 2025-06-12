FactoryBot.define do
  factory :cv do
    email { "willnguyen@gmail.com"}
    status { 0 }
    state { 'scanned' }
    applicant
  end
end