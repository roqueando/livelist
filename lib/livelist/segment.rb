# frozen_string_literal: true

module Livelist
  class Segment
    def initialize(src, duration)
      @src = src
      @duration = duration
    end

    # Append a new segment on playlist file
    # @param [Livelist::Playlist] playlist
    def append(playlist)
      return write(playlist) if File.exist? playlist.path
    end

    # Append a new segment but removing 
    # the previous segment from playlist
    # @param [Livelist::Playlist] playlist
    def hls_append(playlist)
      return hls_write(playlist) if File.exist? playlist.path
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

    # @param [Livelist::Playlist] playlist
    def hls_write(playlist)
      segment = File.open(playlist.path, 'r') do |file|
        context = file.readlines.map(&:chomp)
        remove_tag_and_segment(context)
      end
      File.open(playlist.path, 'w') { |f| f.puts segment }
    end

    def remove_tag_and_segment(context) 
      context.delete_at 5
      context.delete_at 5
      context
    end
  end
end
