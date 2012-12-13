module BigosInstagramBox
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      def bigos_instagram_box_widget
        Instagram.configure do |config|
          config.client_id = BigosInstagramBox.client_id
          config.client_secret = BigosInstagramBox.client_secret
        end
        posts = []
        begin
          items = Instagram.tag_recent_media(
              BigosInstagramBox.hashtag,
              :max_tag_id => BigosInstagramBox.max_tag_id,
              :count=>BigosInstagramBox.count
          )

          items.data.each do |photo_hash|
            posts<< BigosInstagramBox::InstagramPhoto.new(photo_hash)
          end
        rescue
          Rails.logger.error("Instagram API ERROR")
        end

        render :partial=>"bigos_instagram_box/module/widget", :locals=>{:posts => posts}
      end


    end
  end
end