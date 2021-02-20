# frozen_string_literal: true

module Livelist
  # Livelist::HLS
  module HLS
    def self.current_time(playlist, seconds = 2)
      lines = File
              .readlines(playlist)
              .select { |line| line =~ /EXTINF:[0-9]/ }
      lines.length * seconds
    end
  end
end
