module Errors
  class Base < StandardError
    attr_reader :message, :status, :details

    def initialize(message: nil, status: nil, details: nil)
      @message = message || default_message
      @status = status || default_status
      @details = details
    end

    def name
      self.class.name
    end

    private

    def default_status
      :bad_request
    end

    def default_message
      'Unprocessed error'
    end
  end

  class InvalidCredentials < Base
    def default_status
      :unauthorized
    end

    def default_message
      'You provide invalid user token'
    end
  end

  class InvalidRequestData < Base
    def default_status
      :bad_request
    end

    def default_message
      'Invalid request'
    end
  end

  class Unauthenticated < Base
    def default_message
      'Authentication is required to perform this request'
    end

    def default_status
      :unauthorized
    end
  end

  class Unright < Base
    def default_message
      'You are not allowed to do this.'
    end

    def default_status
      :unright
    end
  end

  class Ban < Base
    def default_message
      'You are banned.'
    end

    def default_status
      :ban
    end
  end
end
