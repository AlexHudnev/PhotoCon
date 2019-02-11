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
end
