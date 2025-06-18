module Resolvers
  class UserList < BaseResolver
    type Types::UserCollectionType, null: true

    argument :page_index, Int, required: false, default_value: 1
    argument :page_size, Int, required: false, default_value: 20
    argument :email, String, required: false, default_value: ''

    def resolve(page_size:, page_index:, email:)

      if email
        users = User.page(page_index).per(page_size)
            .where('email ILIKE ?', "%#{email}%")
      else
        users = User.page(page_index).per(page_size)
      end

      {
        users:      users.decorate,
        total:     users.total_count,
        page:      page_index,
        page_size: page_size,
      }
    end

  end
end
