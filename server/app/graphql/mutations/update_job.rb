module Mutations
  class UpdateJob < GraphQL::Schema::RelayClassicMutation
    argument :job_id, String, required: true
    argument :attributes, Types::JobAttributes, required: true

    field :job, Types::JobType, null: true
    field :error, String, null: true

    def resolve(job_id:, attributes:)
      job        = Job.find(job_id)
      job.update(params_hash(attributes))
      {job: job}
    rescue ActiveRecord::RecordInvalid => e
      {error: e.record.errors.full_messages.first}
    rescue ActiveRecord::RecordNotFound
      {error: "Job not found"}
    end

    private

    def params_hash(attributes)
      ActionController::Parameters.new(attributes.to_h).permit!
    end
  end
end
