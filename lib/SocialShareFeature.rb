require "SocialShareFeature/version"
require 'share_count'
require 'share_button'

module SocialShareFeature
  class Error < StandardError; end
  # Your code goes here...
  module Count
    extend ShareCount
  end
  module Button
    extend ShareButton
  end
  class << self
    attr_accessor :facebook_token_for_count,:allow_sites_for_share_button
    def configure
      yield self.config
    end
  end
end
