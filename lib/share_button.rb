require "share_button/config"
require "share_button/helper"
# require "config"
# require "helper"

# I18n.load_path += Dir.glob( File.dirname(__FILE__) + "lib/locales/*.{rb,yml}" )

module ShareButton
  NETWORK_LIST = [
    :facebook,
    :google,
    :linkedin,
    :pinterest,
    :reddit,
    :twitter,
    :weibo
  ]
  def supported_networks
    NETWORK_LIST
  end
  module Rails
    if ::Rails.version < "3.1"
      require "share_button/railtie"
    else
      require "share_button/engine"
    end
  end
end

ActiveSupport.on_load(:action_view) do
  include ShareButton::Helper
end

# SocialShareButton.configure do |config|
#   config.allow_sites = %w(twitter facebook google_plus weibo qq douban google_bookmark
#                           delicious tumblr pinterest email linkedin wechat vkontakte
#                           xing reddit hacker_news telegram odnoklassniki whatsapp_app whatsapp_web)
# end
