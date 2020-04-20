# frozen_string_literal: true

class ReportsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'ReportsChannel'
  end
end
