require 'groupme/group'
require 'groupme/api/utils'

module GroupMe
  class API
    module Groups
      include GroupMe::API::Utils

      # List the authenticated user's active groups
      #
      # @see https://dev.groupme.com/docs/v3#groups_index
      # @return [Array<GroupMe::Group>]
      # @param options [Hash] A customizable set of options
      # @option options [Integer] :page Fetch a particular page of results. Defaults to 1.
      # @option options [Integer] :per_page Define page size. Defaults to 10.
      def groups(options = {})
        objects_from_response(GroupMe::Group, :get, '/groups', options)
      end

      # List the groups you have left bug can rejoin
      #
      # @see https://dev.groupme.com/docs/v3#groups_index_former
      # @return [Array<GroupMe::Group>]
      def former_groups
        objects_from_response(GroupMe::Group, :get, '/groups/former')
      end

      # Load a specfic group
      #
      # @see https://dev.groupme.com/docs/v3#groups_show
      # @param id [Integer, String]
      # @return [GroupMe::Group]
      def group(id)
        object_from_response(GroupMe::Group, :get, "/groups/#{id}")
      end
    end
  end
end
