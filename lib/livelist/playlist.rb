# frozen_string_literal: true

module Livelist
  # A Playlist m3u8
  class Playlist
    # @param path [String] where will be the final m3u8
    #
    # @param options [Hash] all options allowed 
    # @option options [Integer] :version playlist version defaults 1
    # @option options [Boolean] :allow playlist allow cache defaults false
    # @option options [Integer] :target_duration playlist target duration in seconds defaults 10
    #
    # @raise [Exceptions::InvalidFormat] invalid format if file is not a .m3u8
    def initialize(path, options = {})
      @path = path
      @options = options
      @tag = "#EXTM3U"
      raise Exceptions::InvalidFormat unless File.extname(path) == '.m3u8'
    end

    def path
      @path
    end

    # Write the m3u8 file
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

    # Return a string version of m3u8 file
    def to_s
      [
        @tag,
        version,
        media_sequence,
        allow_cache?,
        target_duration
      ].join("\n")
    end

    private
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
  end
end
