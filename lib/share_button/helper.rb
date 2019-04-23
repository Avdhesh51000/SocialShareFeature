module ShareButton
  module Helper

    def social_share_button_tag(title, opts = {})
      @opts = opts
      @opts[:allow_sites] ||= ShareButton.config.allow_sites
      @html = []
      @html << "<div class='share-button' data-title='#{h title}' data-img='#{opts[:image]}'"
      @html << "data-url='#{opts[:url]}' data-desc='#{opts[:desc]}' data-via='#{opts[:via]}'>"
      generate_link
      @html << "</div>"
      raw @html.join("\n")
    end

    def generate_link
      @extra_data = {}
      @rel = @opts[:rel]
      if @opts[:allow_sites].class == Array 
        @opts[:allow_sites].each do |name|
          links name   
        end
      else
        links @opts[:allow_sites]
      end
    end

    def links name
      @extra_data = @opts.select { |k, _| k.to_s.start_with?('data') } if name.eql?('tumblr')
      special_data = @opts.select { |k, _| k.to_s.start_with?('data-' + name) }
      special_data["data-wechat-footer"] = t "social_share_button.wechat_footer" if name == "wechat"
      link_title = "#{name.capitalize}"
      # "<img src='images/social-icon1.png' class='w-100'>"
      # link_title = t "social_share_button.share_to", :name => t("social_share_button.#{name.downcase}")
      @html << link_to("#", { :rel => ["nofollow", @rel],
       "data-site" => name,
       :class => @opts[:class],
       :onclick => "return ShareButton.share(this);",
       :title => h(link_title) }.merge(@extra_data).merge(special_data)) do 
           @opts[:img].present? ? "<img src='#{@opts[:img][:src]}' class='#{@opts[:img][:class]}'>".html_safe : name.capitalize
      end
    end

  end
end
