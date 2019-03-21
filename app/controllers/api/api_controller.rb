# frozen_string_literal: true

module Api
  class ApiController < ApplicationController
    def validate(outcome)
      if outcome.valid?
        render json: { message: 'Created' }, status: :ok
      else
        render json: outcome.errors, status: :unprocessable_entity
      end
    end
  end
end
