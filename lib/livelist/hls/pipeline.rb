# frozen_string_literal: true

module Livelist
  module HLS
    # A pipeline for manipulate playlist
    # using HTTP Livestreaming standards
    class Pipeline
      # @param [String] path
      # @param [Hash] options
      def initialize(path, options = {})
        @path = path
        @options = options
        @playlist = Livelist::Playlist.new(@path, options)
      end

      # Run the pipeline to HTTP streaming
      # @param [String] segment_name
      # @return [void]
      def run(segment_name)
        create_playlist
        append_segment(segment_name)
      end

      private
      # Write the playlist file
      def create_playlist
        return @playlist.write unless File.exist? @path
      end

      # Append a segment to playlist file
      # the segment name can be a URL or a simple file
      #
      # @param [String] segment_name
      def append_segment(segment_name)
        Livelist::Sequence.new(@playlist)
          .add
        Livelist::Segment.new(segment_name, @options[:target_duration].to_f)
          .hls_append(@playlist)
      end
    end
  end
end
