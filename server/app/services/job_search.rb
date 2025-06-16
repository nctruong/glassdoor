class JobSearch < Base

  def call
    if params[:title]
      Job.search(query: { match: { title: params[:title] } }).records
    else
      Job.none
    end
  end
end