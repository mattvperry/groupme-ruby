require 'groupme/base'

module GroupMe
  class Group < GroupMe::Base
    attr_reader :id, :name, :phone_number, :type, :description,
      :image_url, :share_url
  end
end
