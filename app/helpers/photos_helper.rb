# frozen_string_literal: true

module PhotosHelper
  # api
  class Vkontakte
    include HTTParty
    base_uri 'https://api.vk.com'

    def initialize(params)
      @options = { query: params }
    end

    def getall
      self.class.get('/method/photos.getAll?', @options)
    end
  end

  # sharing photo
  class Sharing
    def share(photo, url)
      photo.share += 1
      photo.save
      ref = 'http://vk.com/share.php?url=' + url
      ref + '&image=' + photo.photography.url + '&title=' + photo.name
    end
  end
end
