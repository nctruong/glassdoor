class ApplicantDecorator < Draper::Decorator
  delegate_all

  def skill_tag_details
    applicant_skill_tags.map do |applicant_skill_tag|
      "#{applicant_skill_tag.score} - #{applicant_skill_tag.skill_tag.name}"
    end.join(', ')
  end

  def last_approved_at
    @_last_approved_at ||= applications.approved.last&.created_at
  end

  def sent_frequency
    case last_approved_at
    when 120.days.ago..Time.current
      Frequency::DAILY
    when 240.days.ago..120.days.ago
      Frequency::THREE_TIMES_PER_WEEK
    when 550.days.ago..240.days.ago
      Frequency::WEEKLY
    else
      Frequency::ONE_TIME_PER_TWO_WEEK
    end
  end
end
