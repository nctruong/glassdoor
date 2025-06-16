module ElasticsearchHelpers
  def refresh_elasticsearch_index(klass)
    klass.__elasticsearch__.refresh_index!
  end
end

RSpec.configure do |config|
  config.include ElasticsearchHelpers
end
