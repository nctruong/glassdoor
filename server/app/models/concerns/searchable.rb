module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    after_commit on: [:create, :update] do
      __elasticsearch__.index_document
    end

    settings index: {
      number_of_shards: 1,
      analysis:         {
        analyzer: {
          custom_text_analyzer: {
            tokenizer: 'standard',
            filter:    ['lowercase', 'asciifolding']
          }
        }
      }
    } do
      mappings dynamic: 'false' do
        indexes :title, type: :text, analyzer: 'custom_text_analyzer'
        indexes :status, type: :keyword
        indexes :published_at, type: :date
      end
    end
  end

  class_methods do
    def import_index
      self.__elasticsearch__.create_index!(force: true)
      import
    end
  end
end
