module BigosInstagramBox
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      def bigos_instagram_box_widget(max_tag_id = nil, count = 120, posts = [])

        Instagram.configure do |config|
          config.client_id = BigosInstagramBox.client_id
          config.client_secret = BigosInstagramBox.client_secret
        end

        get_by_hash(posts, max_tag_id, count)unless BigosInstagramBox.hashtag.blank?
        get_by_user(posts, max_tag_id, count) unless BigosInstagramBox.user_id.blank?
        search_and_get_by_user_name(posts, max_tag_id, count) unless BigosInstagramBox.user_name.blank?
        get_by_location(posts, max_tag_id, count) unless BigosInstagramBox.location.blank?


        render :partial=>"bigos_instagram_box/module/widget", :locals=>{:posts => posts}

      end

      def get_by_user_id(posts, max_tag_id, count, id, pages = [])
        begin
          items = Instagram.user_recent_media(
              id,
              :max_id => max_tag_id,
              :count => count,
              :access_token => BigosInstagramBox.access_token
          )
          next_id = items.pagination.next_max_id

          items.each do |photo_hash|
            posts << BigosInstagramBox::InstagramPhoto.new(photo_hash)
          end

          if (posts.length < count) && !next_id.nil? && !pages.include?(next_id)
            puts "MAX TAG ID" + next_id
            pages << next_id
            get_by_user_id(posts, next_id, count, id, pages)
          end
        rescue
          Rails.logger.error("Instagram by User ID API ERROR")
        end
      end

      def search_and_get_by_user_name(posts, max_tag_id, count)
        begin
          users = Instagram.user_search(BigosInstagramBox.user_name)
          users.each do |user|
            get_by_user_id(posts, max_tag_id, count, user.id)
          end
        rescue
          Rails.logger.error("Instagram find USER ERROR")
        end
      end

      def get_by_user(posts, max_tag_id, count)
        get_by_user_id(posts, max_tag_id, count, BigosInstagramBox.user_id)
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
