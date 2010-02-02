require 'thor'
require 'persvr'
require 'fileutils'

module Persvr
  class Command < Thor
    include Thor::Actions
    namespace :persvr 
    source_paths << File.join(PERSVR_HOME,'resource','persevere_home')
    source_paths << File.join(PERSVR_HOME,'resource','persevere_pages')
    
    desc "create PATH_TO_INSTANCE", "creates a persevere instance"
    def create(path)
      raise "A file or directory already exists at #{path}" if File.exist?(path)
      
      directory 'WEB-INF', File.join(path,'WEB-INF')
      copy_file 'index.html', File.join(path,'index.html')
    end
    
    desc "clear PATH_TO_INSTANCE", "clears the persevere database"
    def clear(path)
      raise "No instance was found at #{path}" unless File.exist?(path)
      Dir[File.join(path,'WEB-INF','data/*')].each do |file|
        FileUtils.rm_rf file
      end
    end
    
    desc "start [PATH_TO_INSTANCE]", "runs the persevere instance"
    method_option :port, :type => :numeric, :default => 8080, :alias => "-p"
    method_option :uri, :type => :string, :default => "/", :alias => "-u"
    def start(path='.')
      require 'jettr/command'
      jettr = Jettr::Command.new([], options)
      jettr.invoke(:start, [path])
    end
  end
end