## BigosInstagramBox
Widget showing Instagram post for given hash, user id or localization. 

## Installation

BigosInstagramBox works with Rails 3.1 onwards. You can add it to your Gemfile with:

```ruby
gem "bigos_instagram_box", :git=>"git://github.com/kremenso/bigos_instagram_box.git"
```

Run the bundle command to install it.

After you install BigosInstagramBox and add it to your Gemfile, you need to run the generator:

```console
rails generate bigos_instagram_box:install
```

## Configuration

You should create [Instagram App](http://instagram.com/developer/) get [App Client Id], [App Client Secret] and obtain [App Access Token]

You must use this access token in the initilizers/bigos_instagram_box.rb initializer
You  can specify one, two or three methods (By hashtag, user id and location). Posts will be merged

```ruby
BigosInstagramBox.setup do |config|
  config.client_id = "YOUR_APP_ACCESS_TOKEN"
  config.client_secret = "YOUR_APP_CLIENT_SECRET"
  config.access_token = "YOUR_APP_ACCESS_TOKEN"
  config.hashtag = "INSTAGRAM HASHTAG"
  config.user_id = "INSTAGRAM USER"
  config.location = ["latitude", "longitude"]
end
```


## Customization

You can use to generate view you can overwrite
```console
rails generate bigos_instagram_box:views
```

### Usage

In your view add (ERB):
```ruby
<%= bigos_instagram_box_widget %>
```
