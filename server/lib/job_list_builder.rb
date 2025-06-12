class JobListBuilder
  attr_reader :jobs

  JOB_SCOPES = %i[all live pending draft expired deleted created_by_employer offline]

  def initialize(jobs = Job.all)
    @jobs = jobs
  end

  def filtered_jobs_within_scope(admin:, params:)
    if admin
      filtered_jobs_without_scope(admin: admin, params: params)
        .filter_by_scope((params[:scope] || 'all').to_sym)
        .sort_by(params[:sort_field], params[:sort_direction])
        .jobs
    else
      unlogged_in.filter_by_scope((params[:scope] || 'all').to_sym)
                 .sort_by(params[:sort_field], params[:sort_direction])
                 .jobs
    end
  end

  def filtered_jobs_without_scope(admin:, params:)
    JobListBuilder.new
      .show_for(admin)
      .filter_by_title(params[:title])
      .filter_by_skill_tags(params[:skill_tag_ids])
      .filter_by_employer_id(params[:employer_id])
      .filter_by_date_range(params[:date_range])
      .filter_by_credit_provision_date_range(params[:credit_provision_date_range])
      .filter_by_city(params[:city])
      .filter_by_job_type(params[:credit_type])
      .filter_by_sale(params[:sale_id])
  end

  def show_for(admin_user)
    jobs = admin_user&.employer ? Job.where(employer_id: admin_user.employer.id) : Job.where.not(employer:nil)

    self.class.new(jobs)
  end

  def unlogged_in
    jobs = Job.all

    self.class.new(jobs)
  end

  def filter_by_title(title)
    return self if title.blank?
    self.class.new(@jobs.where('title ilike ?', "%#{title}%"))
  end

  def filter_by_employer_id(employer_id)
    return self if employer_id.blank?

    self.class.new(@jobs.where(employer_id: employer_id))
  end

  def filter_by_skill_tags(skill_tag_ids)
    return self if skill_tag_ids.blank?

    self.class.new(@jobs.joins(:skill_tags).where({skill_tags: {id: [skill_tag_ids]}}).distinct)
  end

  def filter_by_city(city)
    return self if city.blank?

    self.class.new(@jobs.where(city: city))
  end

  def filter_by_date_range(date_range)
    return self if date_range.blank?

    start_date, end_date = DateRangeParser.new(date_range).parse
    self.class.new(@jobs.where(published_at: start_date.beginning_of_day..end_date.end_of_day))
  end

  def filter_by_credit_provision_date_range(date_range)
    return self if date_range.blank?

    start_date, end_date = DateRangeParser.new(date_range).parse
    new_jobs = @jobs
                 .joins(:credit)
                 .where(credits: {granted_date: start_date.beginning_of_day..end_date.end_of_day})
    self.class.new(new_jobs)
  end

  def filter_by_scope(scope)
    return self unless scope.in? JOB_SCOPES
    self.class.new(@jobs.send(scope))
  end

  def sort_by(field, direction)
    self.class.new(@jobs.sort_with(field: field || 'created_at', direction: direction || 'desc'))
  end

  # Params:
  #   credit_type: 1, 2, 3 or 4 in string
  def filter_by_job_type(credit_type)
    return self if credit_type.blank?

    self.class.new(@jobs.where(credit_type: credit_type.to_i))
  end

  def filter_by_sale(sale_id)
    return self if sale_id.blank?

    latest_payment_info_ids = PaymentInfo.group(:employer_id).maximum(:id).values
    employer_ids            = PaymentInfo.where(sale_id: sale_id, id: latest_payment_info_ids).pluck(:employer_id).uniq

    self.class.new(@jobs.where(employer_id: employer_ids))
  end
end
