require 'groupme/base'

module GroupMe
  class Bot < GroupMe::Base
    attr_reader :bot_id, :group_id, :name, :avatar_url, :callback_url
    alias :id :bot_id
  end
end
