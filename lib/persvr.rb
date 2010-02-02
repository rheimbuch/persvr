$:.unshift(File.expand_path(File.dirname(__FILE__))) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'java'
begin
  require 'jettr'
rescue LoadError
  puts "Could not load jettr. Please install jettr gem or add to loadpath."
end

module Persvr
  PERSVR_HOME = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined? PERSVR_HOME
  # Dir[File.join(File.dirname(__FILE__),'persvr','jars','*.jar')].each {|jar| require jar}
end


