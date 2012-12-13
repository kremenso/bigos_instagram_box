module BigosInstagramBox
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      def bigos_instagram_box_widget(max_tag_id = nil, count = 60)

        Instagram.configure do |config|
          config.client_id = BigosInstagramBox.client_id
          config.client_secret = BigosInstagramBox.client_secret
        end

        posts = []
        get_by_hash(posts, max_tag_id, count) unless BigosInstagramBox.hashtag.blank?
        get_by_user(posts, max_tag_id, count) unless BigosInstagramBox.user_id.blank?
        get_by_location(posts, max_tag_id, count) unless BigosInstagramBox.location.blank?

        render :partial=>"bigos_instagram_box/module/widget", :locals=>{:posts => posts}
      end


      def get_by_user(posts, max_tag_id, count)
        begin
          items = Instagram.user_recent_media(
            BigosInstagramBox.user_id,
            :max_tag_id => max_tag_id,
            :count => count,
            :access_token => BigosInstagramBox.access_token
          )
          items.each do |photo_hash|
           posts << BigosInstagramBox::InstagramPhoto.new(photo_hash)
          end
        rescue
          Rails.logger.error("Instagram by User API ERROR")
        end
      end

      def get_by_hash(posts, max_tag_id, count)
        begin
          items = Instagram.tag_recent_media(
            BigosInstagramBox.hashtag,
           :max_tag_id => max_tag_id,
           :count => count
          )
          items.data.each do |photo_hash|
            posts << BigosInstagramBox::InstagramPhoto.new(photo_hash)
          end
        rescue
          Rails.logger.error("Instagram by Hash API ERROR")
        end
      end

      def get_by_location(posts, max_tag_id, count)
        begin
          items = Instagram.media_search(BigosInstagramBox.location.first, BigosInstagramBox.location.second)
          items.data.each do |photo_hash|
            posts << BigosInstagramBox::InstagramPhoto.new(photo_hash)
          end
        rescue
          Rails.logger.error("Instagram by Location API ERROR")
        end
      end

    end
  end
end