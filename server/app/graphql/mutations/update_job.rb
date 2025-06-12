module Mutations
  class UpdateJob < GraphQL::Schema::RelayClassicMutation
    argument :job_id, String, required: true
    argument :attributes, Types::JobAttributes, required: true

    field :job, Types::JobType, null: true
    field :error, String, null: true

    def resolve(job_id:, attributes:)
      job        = Job.find(job_id)

      {job: job}
    rescue ActiveRecord::RecordInvalid => e
      {error: e.record.errors.full_messages.first}
    rescue ActiveRecord::RecordNotFound
      {error: "Job not found"}
    end

    private

    def params_hash(attributes)
      hash             = attributes.to_h
      hash[:benefit_1] = hash[:benefit1]
      hash[:benefit_2] = hash[:benefit2]
      hash[:benefit_3] = hash[:benefit3]
      hash.merge!(primary_job_skill_tag_attributes: {skill_tag_id: hash[:primary_skill_tag_id]})
      ActionController::Parameters.new(job: hash)
    end
  end
end
