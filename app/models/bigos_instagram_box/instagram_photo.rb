module BigosInstagramBox
  class InstagramPhoto



    def initialize(hash)
      @data = hash
      #super
    end

    def data
      @data
    end

    def image_low_url
      return nil unless data
      self.data["images"]["thumbnail"]["url"]
    end

    def image_med_url
      return nil unless data
      self.data["images"]["low_resolution"]["url"]
    end

    def image_high_url
      return nil unless data
      self.data["images"]["standard_resolution"]["url"]
    end

    def link
      self.data.link
    end

    def author_name
      self.data["user"]["full_name"]
    end

    def author_picture
      self.data["user"]["profile_picture"]
    end

    def identifier
      self.data["id"]
    end

    def date_ago
      Time.at(self.data.created_time.to_i)
    end

    def author
      self.data.user.username
    end

    def description
      if self.data.caption
        self.data.caption.text
      else
        nil
      end
    end

  end
end
