# frozen_string_literal: true

module Livelist
  # Initialize and separate by headers and segments
  # all playlist files
  class Playlist
    def initialize(path, options = {})
      @path = path
      @options = options
      @tag = "#EXTM3U"
      raise Exceptions::InvalidFormat unless File.extname(path) == '.m3u8'
    end

    def version
      "#EXT-X-VERSION:#{@options[:version] ||= 1}"
    end

    def allow_cache?
      "#EXT-X-ALLOW-CACHE:#{@options[:allow] ? 'YES' : 'NO'}"
    end

    def target_duration
      "#EXT-X-TARGET-DURATION:#{@options[:target_duration] ||= 10}"
    end

    def media_sequence
      "#EXT-X-MEDIA-SEQUENCE:0"
    end

    def path
      @path
    end

    def write
      File.open(@path, 'w') do |file|
        [
          @tag,
          version,
          media_sequence,
          allow_cache?,
          target_duration
        ].each { |tag| file.puts tag }
      end
    end

    def to_s
      [
        @tag,
        version,
        media_sequence,
        allow_cache?,
        target_duration
      ].join("\n")
    end
  end

end
