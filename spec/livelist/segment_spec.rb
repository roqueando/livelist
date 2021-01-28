require 'spec_helper'

RSpec.describe Livelist::Segment do
  let(:file_name) { 'spec/output/index.m3u8' }
  before(:each) do 
    @playlist = Livelist::Playlist.new(file_name)
    @playlist.write
  end

  it 'should append a new segment to a playlist' do
    Livelist::Segment.new('test.ts', 2.00)
      .append(@playlist)

    file_line = File.open(@playlist.path, 'r') do |f|
      f.find { |line| line =~ /#EXTINF:/ }
    end

    expect(file_line).to match(/#EXTINF:/)
  end
end
