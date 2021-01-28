require 'spec_helper'

RSpec.describe Livelist::HLS::Pipeline do

  context 'when run pipeline' do
    let(:filename) { 'spec/output/index.m3u8' }
    it 'should media sequence add 1' do
      Livelist::HLS::Pipeline.new(filename)
        .run('test.ts')

      file_line = File.open(filename, 'r') do |f|
        f.find { |line| line =~ /#EXTINF:/ }
      end

      expect(file_line).to be nil
    end
  end
end
