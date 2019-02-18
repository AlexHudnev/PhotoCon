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

  class ZipPhotos
    # create zip all photos
    def make_zip
      zipfile_name = "#{Rails.root}/public/uploads/tmp/allphoto.zip"
      File.delete(zipfile_name) if File.exist?(zipfile_name)
      Photo.all.each do |photo|
        arr = photo.photography.url.split('/')
        folder = "#{Rails.root}/public/uploads/photo/photography/" + arr[4]
        input_filenames = [arr[5]]
        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
          input_filenames.each do |filename|
            zipfile.add(filename, File.join(folder, filename))
          end
        end
      end
      zipfile_name
    end
  end
end
