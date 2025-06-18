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
    field :page, Int, null: true
    field :page_size, Int, null: true

    def data
      collection
    end

    def total
      collection.total_count
    end

    def page
      params[:page_index]
    end

    def page_size
      params[:page_size]
    end

    private

    def collection
      if params[:candidate_name]
        JobApplication.search(query: { match: { fullname: params[:candidate_name] } })
                      .records
                      .page(params[:page_index])
                      .per(params[:page_size])
      else
        JobApplication
          .page(params[:page_index])
          .per(params[:page_size])
      end
    end

    def params
      object[:params]
    end

  end
end
