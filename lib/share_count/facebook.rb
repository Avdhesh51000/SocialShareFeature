module ShareCount
  class Facebook < Base
    # URL = 'http://graph.facebook.com/v2.7/'
    URL = 'https://graph.facebook.com/v3.0/'

    def shares!
      return raise "It's Seems that you have not initilized ' SocialShareFeature.facebook_token_for_count = 515465|12135' in intilizer to use facebook count you need to do this please see usages in README." unless SocialShareFeature.facebook_token_for_count.present?
      token = SocialShareFeature.facebook_token_for_count
      response = get(URL, params: {
                       id: checked_url,
                       fields: 'engagement',
                       access_token: token
      })
      json_response = JSON.parse(response)

      if json_response['engagement']
        json_response['engagement']['share_count'] || 0
      else
        0
      end
    end
  end
end
