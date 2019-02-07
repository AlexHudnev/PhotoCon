# frozen_string_literal: true

# likes controller
class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    outcome = Likes::Create.run(photo: @photo, user: current_user)
    if outcome.valid?
      respond_to do |format|
        format.html do
          redirect_to @photo
        end
        format.js
      end
    else
      flash[:warning] = 'You cant like twice.'
      redirect_to root_path
    end
  end
end
