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

    # Finish the playlist with a endlist tag
    # @param String playlist
    # @return void
    def self.finish(playlist)
      file = File.read(playlist)
      content = file.gsub(/#EXT-X-PLAYLIST-TYPE:EVENT/, '#EXT-X-PLAYLIST-TYPE:VOD')
      File.open(playlist, 'w') { |f| f.puts content}
      File.open(playlist, 'a') do |file|
        file.puts '#EXT-X-ENDLIST'
      end
    end
  end
end
