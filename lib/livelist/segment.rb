# frozen_string_literal: true

module Livelist
  # A Segment to playlist file
  class Segment
    # @param src [String] src can be a URI or a file name
    # @param duration [Float] duration in seconds
    def initialize(src, duration)
      @src = src
      @duration = duration
    end

    # Append a new segment on playlist file
    #
    # @param [Livelist::Playlist] playlist
    def append(playlist)
      write(playlist) if File.exist? playlist.path
    end

    # Append a new segment but removing
    # the previous segment from playlist
    #
    # @param [Livelist::Playlist] playlist
    def hls_append(playlist)
      hls_write(playlist) if File.exist? playlist.path
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
      append(playlist)
      segment = File.open(playlist.path, 'r') do |file|
        context = file.readlines.map(&:chomp)
        remove_tag_and_segment(context)
      end
      File.open(playlist.path, 'w') { |f| f.puts segment }
    end

    # @param context [Array] an array containing tag and segment
    # @return [Array] updated array without tag and segment
    def remove_tag_and_segment(context)
      if context.grep(/#EXTINF:[0-9]+/).length > 2
        context.delete_at 5
        context.delete_at 5
        tag, number = context[3].strip.split(':')
        number = number.to_i + 1
        context[3] = "#{tag}:#{number}"
      end
      context
    end
  end
end
