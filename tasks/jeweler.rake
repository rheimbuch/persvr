begin
  require 'jeweler'
  
  Jeweler::Tasks.new do |gem|
    gem.name = "persvr"
    gem.summary = "Create and run instances of the Persevere JS Database."
    gem.email = "rheimbuch@gmail.com"
    gem.homepage = "http://github.com/rheimbuch/persvr"
    gem.authors = ["Ryan Heimbuch"]
    
    gem.platform = 'java'
    
    gem.files.include ['resource/**/*']
    gem.files.exclude 'resource/persevere_home/WEB-INF/src/**/*'
    
    gem.add_dependency 'jettr'
    gem.add_dependency 'thor'
  end
rescue LoadError
  puts "Jeweler no available. Install with: gem install jeweler"
end