# frozen_string_literal: true

module Livelist
  module Exceptions
    # Livelist::Exceptions::InvalidFormat
    # Throws an error if file has invalid format (if not .m3u8)
    class InvalidFormat < StandardError
      def initialize(message: 'That file has invalid format')
        super(message)
      end
    end
  end
end
