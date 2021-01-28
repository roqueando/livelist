# frozen_string_literal: true

module Livelist
  class Segment
    def initialize(src, duration)
      @src = src
      @duration = duration
    end

    # @param [Livelist::Playlist] playlist
    def append(playlist)
      return write(playlist) if File.exist? playlist.path
    end

    private

    # @param [Livelist::Playlist] playlist
    def write(playlist)
      File.open(playlist.path, 'a') do |file|
        [
          "#EXTINF:#{@duration},",
          @src
        ].each { |line| file.puts line }
      end
    end
  end
end
