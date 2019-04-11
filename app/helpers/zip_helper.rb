# frozen_string_literal: true

module ZipHelper
  class ZipPhotos
    # create zip all photos
    def make_zip
      dir = "#{Rails.root}"
      dir = 'https://1234567890h.s3.amazonaws.com' if Rails.env.production?
      zipfile_name = "#{Rails.root}/public/uploads/tmp/allphoto.zip"
      File.delete(zipfile_name) if File.exist?(zipfile_name)
      Photo.all.each do |photo|
        arr = photo.photography.url.split('/')
        folder = "#{dir}/public/uploads/photo/photography/" + arr[4]
        input_filenames = [arr[5]]
        Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
          input_filenames.each do |filename|
            zipfile.add(photo.id.to_s + '.jpg', File.join(folder, filename))
          end
        end
      end
      zipfile_name
    end
  end
end
