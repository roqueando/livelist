require 'spec_helper'

RSpec.describe Livelist::Playlist do
    let(:file_name) { 'spec/output/index.m3u8' }

    it 'should write a valid m3u8 file with given options' do
      playlist = Livelist::Playlist.new(file_name, {
        :allow => false,
        :target_duration => 2,
        :version => 3
      })
      playlist.write

      expect(File.read(file_name)).not_to be nil
    end

    it 'should write a valid m3u8 file with default options' do
      Livelist::Playlist.new(file_name).write

      expect(File.read(file_name)).not_to be nil
    end

    it 'should return a string with the mounted playlist' do
      expect(Livelist::Playlist.new(file_name).to_s).not_to be nil
    end
end
