require 'faker'

# Clear previous records
[UserJobApplication, JobApplication, JobCandidate, Candidate, Cv, Applicant, Job, Employer, User].each(&:delete_all)

# Create employers
10.times do
  employer = Employer.create!(
    name: Faker::Company.name,
    email: Faker::Internet.email,
    short_description: Faker::Company.catch_phrase[0..99],
    long_description: Faker::Lorem.paragraph_by_chars(number: 800),
    company_type: "Tech",
    culture_description: Faker::Lorem.sentence,
    website_url: Faker::Internet.url,
    country: Faker::Address.country
  )

  # Create users (linked optionally to employer)
  5.times do |num|
    user = User.create!(
      email: Faker::Internet.unique.email,
      password: "password",
      fullname: Faker::Name.name,
      phone: Faker::PhoneNumber.cell_phone,
      employer: [employer, nil].sample
    )

    applicant = Applicant.create!(
      user: user,
      email: user.email,
      cv_level: "Senior",
      last_applied_date: rand(1..30).days.ago,
      latest_status: "Applied"
    )

    # Create CVs
    2.times do
      cv = Cv.create!(
        applicant: applicant,
        email: Faker::Internet.unique.email,
        content: Faker::Lorem.paragraph,
        skill_tags: Faker::Job.key_skill,
        scanned_job_title: Faker::Job.title,
        scanned_employer_names: employer.name,
        status: Cv.statuses[:pending],
        state: Cv.states[:scanned]
      )

      # Create candidate for matching
      candidate = Candidate.create!(
        email: Faker::Internet.unique.email,
        fullname: user.fullname,
        city: Faker::Address.city,
        companies: employer.name,
        phone_number: user.phone,
        first_applied_date: rand(30).days.ago,
        first_approved_date: rand(10).days.ago,
        scanned_email: user.email,
        latest_cv_id: cv.id
      )

      # Create jobs for employer
      job = Job.create!(
        title: Faker::Job.title,
        employer: employer,
        address: Faker::Address.full_address,
        description: Faker::Job.field,
        salary: "#{rand(50..150)}k",
        published_at: Time.now - 7.days,
        expired_at: Time.now + 30.days,
        status: 'active'
      )

      # Create job application
      job_app = JobApplication.create!(
        applicant: applicant,
        cv: cv,
        job: job,
        email: user.email,
        fullname: user.fullname,
        email_to_candidate_status: true,
        email_to_employer_status: false
      )

      # Link user to job application
      UserJobApplication.create!(
        user: user,
        job_application: job_app
      )

      # Create job candidate entry
      JobCandidate.create!(
        job: job,
        cv: cv,
        candidate: candidate,
        score: rand(1.0..10.0).round(2),
        invited_at: rand(5..10).days.ago,
        accepted_at: rand(1..4).days.ago,
        viewed_at: Time.now,
        status: JobCandidate.statuses.keys.sample
      )
    end
  end
end

puts "✅ Seed complete!"