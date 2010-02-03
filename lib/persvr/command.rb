require 'thor'
require 'persvr'
require 'fileutils'

module Persvr
  class Command < Thor
    include Thor::Actions
    source_paths << File.join(PERSVR_HOME,'resource','persevere_home')
    source_paths << File.join(PERSVR_HOME,'resource','persevere_pages')
    
    desc "create PATH_TO_INSTANCE [-f]", "creates a persevere instance"
    method_option :force, :type => :boolean, :default => false, :aliases => '-f'
    def create(path)      
      directory 'WEB-INF', File.join(path,'WEB-INF'), :force => options[:force]
      copy_file 'index.html', File.join(path,'index.html'), :force => options[:force]
    end
    
    desc "clear PATH_TO_INSTANCE", "clears the persevere database"
    def clear(path)
      raise "No instance was found at #{path}" unless File.exist?(path)
      Dir[File.join(path,'WEB-INF','data/*')].each do |file|
        FileUtils.rm_rf file
      end
    end
    
    desc "start [PATH_TO_INSTANCE]", "runs the persevere instance"
    method_option :port, :type => :numeric, :default => 8080, :aliases => "-p"
    method_option :uri, :type => :string, :default => "/", :aliases => "-u"
    def start(path='.')
      require 'jettr/command'
      jettr = Jettr::Command.new([], options)
      jettr.invoke(:start, [path])
    end
  end
end