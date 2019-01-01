class MainPagesController < ApplicationController
  def home
	@photos = Photo.all
  end
end
