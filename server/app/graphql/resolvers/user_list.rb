module Resolvers
  class UserList < BaseResolver
    type [Types::UserType], null: true

    argument :page_index, Int, required: false, default_value: 1
    argument :page_size, Int, required: false, default_value: 20
    argument :email, String, required: false, default_value: ''

    def resolve(page_size:, page_index:, email:)
      User.page(page_index).per(page_size)
        .where('email ILIKE ?', "%#{email}%")
        .decorate
    end

  end
end
