require "bigos_instagram_box/engine"
require "instagram"

module BigosInstagramBox

  mattr_accessor :client_id
  @@client_id = nil

  mattr_accessor :client_secret
  @@client_secret = nil

  mattr_accessor :hashtag
  @@hashtag = nil

  mattr_accessor :max_tag_id
  @@hashtag = nil

  mattr_accessor :count
  @@hashtag = 60

  module Controllers
    autoload :Helpers, 'bigos_instagram_box/controllers/helpers'
  end




  def self.setup
    include_helpers
    yield self
  end

  # Include helpers to AC and AV.
  def self.include_helpers
    ActiveSupport.on_load(:action_controller) do
    end

    ActiveSupport.on_load(:action_view) do
      include BigosInstagramBox::Controllers::Helpers
    end
  end

end
