# SocialShareFeature

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/SocialShareFeature`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'SocialShareFeature'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install SocialShareFeature
## Usage

Add this line to your application's initializers file.
```ruby
require 'SocialShareFeature'
```
For Facebook share count we need to initialize the facebook token which we can get from https://developers.facebook.com/ and create your own app
and go to https://developers.facebook.com/apps/YOURAPPID/settings/basic/ And copy YOUR App ID and App Secret

	EX: YOURAPPID = "2254794191441963"

Add this line to initilizers file:
```ruby
	SocialShareFeature.facebook_token_for_count= "Your App ID|Your App Secret"
```
	where **This is only Example use your own details**
	Your App ID = "2254794191441963"
	Your App Secret = "247c3641f30468d363bf8a827d6e673a"

Get The Count of Social Share
```ruby
 social_count = SocialShareFeature::Count.selected "https://www.google.com/", %w(facebook reddit)
```
Get The List of Supported Network For Count:
```ruby
SocialShareFeature::Count.supported_networks
 => [:facebook, :google, :reddit, :weibo] 
```

Get The List of Supported Network For Share Button:
```ruby
SocialShareFeature::Button.supported_networks
 => [:facebook, :google, :linkedin, :pinterest, :reddit, :twitter, :weibo] 
```
## To Use Social Share Button you required

You need add require js file in your app assets files and add Jquery in your Project:

app/assets/javascripts/application.js
```js
//= require share_button
// if you need use WeChat
//= require share_button/wechat 
```
	**OR**

For app/assets/javascripts/application.coffe
```coffe
#= require share_button
# if you need use WeChat
#= require share_button/wechat 
```

app/assets/stylesheets/application.css
```css
*= require share_button
```
	**OR**
For app/assets/stylesheets/application.scss
In Rails 4.1.6 , use @import to require files:
```scss
@import "share_button";
```

Add Button With Image to view
```ruby
     <%= social_share_button_tag('',:allow_sites => 'facebook',img: {src: 'http://Default Image Url.com/',class: 'class for default image'}, :url => "https://my shatring url/", :image => "https://my image url.com/", desc: 'The summary of page',class: 'my class to btn') %>
```
Add a link Without image to view
```ruby
      <%= social_share_button_tag('Facebook',:allow_sites => 'facebook', :url => "https://my shatring url/", :image => "https://my image url.com/", desc: 'The summary of page',class: 'my class to btn') %>
```

If you want multiple socal share links at a same time Then you can use this
Define This in  initilizers file:
```ruby
SocialShareFeature.allow_sites_for_share_button =  %w(twitter facebook weibo)
```
Add Button With Image to view
```ruby
     <%= social_share_button_tag(:url => "https://my shatring url/", :image => "https://my image url.com/", desc: 'The summary of page',class: 'my class to btn') %>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/SocialShareFeature. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SocialShareFeature project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/SocialShareFeature/blob/master/CODE_OF_CONDUCT.md).
