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

      # Create a new group
      #
      # @see https://dev.groupme.com/docs/v3#groups_create
      # @param name [String]
      # @param options [Hash] a customizable set of options
      # @option options [String] :description
      # @option options [String] :image_url
      # @option options [Boolean] :share If you pass a true value for share,
      #   we'll generate a share URL. Anybody with this URL can join the group.
      def create_group(name, options = {})
        options[:name] = name
        object_from_response(GroupMe::Group, :post, '/groups', options)
      end

      # Update a group after creation
      #
      # @see https://dev.groupme.com/docs/v3#groups_update
      # @param group [Integer, String, GroupMe::Group] Group to update
      # @param options [Hash] a cusomizable set of options
      # @option options [String] :name
      # @option options [String] :description
      # @option options [String] :image_url
      # @option options [Boolean] :share If you pass a true value for share,
      #   we'll generate a share URL. Anybody with this URL can join the group.
      def update_group(group, options = {})
        id = extract_id group
        object_from_response(GroupMe::Group, :post, "/groups/#{id}/update", options)
      end

      # Disband a group
      #
      # @see https://dev.groupme.com/docs/v3#groups_destroy
      # @param group [Integer, String, GroupMe::Group] Group to update
      def destroy_group(group)
        id = extract_id group
        post("/groups/#{id}/destroy")
      end
    end
  end
end
