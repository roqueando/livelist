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
      Livelist::HLS::Pipeline
        .new(filename, target_duration: 2)
        .run('test3.ts')
      Livelist::HLS::Pipeline
        .new(filename, target_duration: 2)
        .run('test4.ts')
    end

    it 'should media sequence add after three' do
      run_pipeline
      file_line = File.open(filename, 'r') do |f|
        f.find_all { |line| line =~ /#EXTINF:/ }
      end
      sequence_line = File.open(filename, 'r') do |f|
        f.find { |line| line =~ /#EXT-X-MEDIA-SEQUENCE/ }
      end

      _tag, number = sequence_line.strip.split(':')
      expect(file_line.length).to be > 0
      expect(number.to_i).to be > 0
    end

    it 'should create a HLS event type' do
      type_tag = File.open(filename, 'r') do |f|
        f.find { |line| line =~ /#EXT-X-PLAYLIST-TYPE/ }
      end
      _tag, type = type_tag.strip.split(':')

      expect(type_tag).not_to be_nil
      expect(type).to eq('EVENT')
    end

    it 'should get current time in seconds' do
      current_time = Livelist::HLS.current_time(filename)
      expect(current_time).to eq(4)
    end

    it 'should finish a pipeline HLS displaying a VOD headers' do
      Livelist::HLS.finish(filename)

      file_line = File.open(filename, 'r') do |f|
        f.find { |line| line =~ /#EXT-X-ENDLIST/ }
      end

      type_tag = File.open(filename, 'r') do |f|
        f.find { |line| line =~ /#EXT-X-PLAYLIST-TYPE:VOD/ }
      end

      _tag, type = type_tag.strip.split(':')

      expect(type_tag).not_to be_nil
      expect(file_line).not_to be_nil
      expect(type).to eq('VOD')
    end
  end
end
