require 'groupme/bot'
require 'groupme/api/utils'

module GroupMe
  class API
    module Bots
      include GroupMe::API::Utils

      # List bots that you have created
      #
      # @see https://dev.groupme.com/docs/v3#bots_create
      def bots
        objects_from_response(GroupMe::Bot, :get, '/bots')
      end

      # Post a message from a bot
      #
      # @see https://dev.groupme.com/docs/v3#bots_post
      # @param bot [Integer, String, GroupMe::Bot] Bot to post from
      # @param message [String] message to post
      def post_from_bot(bot, message)
        post('/bots/post', {
          bot_id: extract_id(bot),
          text: message
        })
      end

      # Create a bot
      #
      # @see https://dev.groupme.com/docs/v3#bots_create
      # @param name [String] name of bot
      # @param group [Integer, String, GroupMe::Group] group to add bot to
      # @param options [Hash] a customizable set of options
      # @option options [String] :avatar_url
      # @option options [String] :callback_url
      def create_bot(name, group, options = {})
        options.merge(name: name, group_id: extract_id(group))
        options = { bot: options }
        object_from_response(GroupMe::Bot, :post, '/bots', options)
      end

      # Remove a bot that you have created
      #
      # @see https://dev.groupme.com/docs/v3#bots_destroy
      # @param bot [Integer, String, GroupMe::Bot] Bot to destroy
      def destroy_bot(bot)
        post('/bots/destroy', bot_id: extract_id(bot))
      end
    end
  end
end
