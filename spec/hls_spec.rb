# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Livelist::HLS::Pipeline do
  context 'when run pipeline' do
    let(:filename) { 'spec/output/index.m3u8' }
    subject(:run_pipeline) do
      Livelist::HLS::Pipeline
        .new(filename, target_duration: 2)
        .run('test0.ts')
      Livelist::HLS::Pipeline
        .new(filename, target_duration: 2)
        .run('test1.ts')
    end
    it 'should media sequence add 1 and remains 1 segment' do
      run_pipeline
      file_line = File.open(filename, 'r') do |f|
        f.find_all { |line| line =~ /#EXTINF:/ }
      end

      expect(file_line.length).to be > 0
    end

    it 'should get current time in seconds' do
      current_time = Livelist::HLS.current_time(filename)
      expect(current_time).to eq(4)
    end
  end
end
