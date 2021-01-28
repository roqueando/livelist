require 'spec_helper'

RSpec.describe Livelist::Sequence do
  let(:file_name) { 'spec/output/index.m3u8' }
  let(:pattern) { /#EXT-X-MEDIA-SEQUENCE:/ }
  before(:each) do
    @playlist = Livelist::Playlist.new(file_name)
    @playlist.write
  end

  it 'should add new sequence to the playlist', focus: true do
    Livelist::Sequence.new(@playlist)
      .add

    file_line = File.open(@playlist.path, 'r') do |f|
      f.find { |line| line =~ pattern }
    end

    _tag, sequence_number = file_line.split(':')

    expect(file_line).to match(pattern)
    expect(sequence_number.strip.to_i).to be(1)
  end
end
