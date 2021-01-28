require 'livelist/version'
Dir[File.dirname(__FILE__) + "/livelist/**/*.rb"].each { |file| require file }

module Livelist
  class Error < StandardError; end
  # Your code goes here...
end
