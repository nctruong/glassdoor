module Types
  class JobApplicationScopeStat < Types::BaseObject
    field :all, Int, null: false
    field :approved, Int, null: true
    field :pending, Int, null: true
    field :rejected_120, Int, null: true
    field :rejected_360, Int, null: true
    field :spam_rejected, Int, null: true
  end

  class JobApplicationCollectionType < Types::BaseObject
    field :scopes, JobApplicationScopeStat, null: true
    field :total, Int, null: true
    field :data, [JobApplicationType], null: true

    def data
      collection
    end

    def total
      collection.total_count
    end

    private

    def collection
      JobApplication
        .page(params[:page_index])
        .per(params[:page_size])
    end

    def params
      object[:params]
    end

  end
end
