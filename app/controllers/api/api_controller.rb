# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    def validate
      if outcome.valid?
        render nothing: true, status: :created
      else
        render json: outcome.errors.symbolic, status: :unprocessable_entity
      end
    end
  end
end
