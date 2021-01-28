# frozen_string_literal: true

module Livelist
  class Sequence
    # @param [Livelist::Playlist] playlist
    def initialize(playlist)
      @playlist = playlist
      @pattern = /#EXT-X-MEDIA-SEQUENCE:[0-9]+/
    end

    # Writes the new sequence on playlist
    def add
      file = File.read(@playlist.path)
      content = file.gsub(@pattern, new_sequence_line(file_line))
      File.open(@playlist.path, 'w') { |f| f.puts content}
    end

    private

    # Return the sequence line adding 1 to the previous value
    # @param [String] line
    def new_sequence_line(line)
      tag, sequence = line.split(':')
      seq = sequence.strip.to_i + 1
      "#{tag}:#{seq}"
    end

    # Return the sequence tag based on regex pattern
    # @return [String]
    def file_line
      File.open(@playlist.path, 'r') do |file|
        file.find { |line| line =~ @pattern }
      end
    end
  end
end
