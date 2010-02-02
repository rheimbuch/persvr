begin
  require 'jeweler'
  gem 'rake-compiler', '~>0.7'
  require 'rake/javaextensiontask'
  
  Jeweler::Tasks.new do |gem|
    gem.name = "persvr"
    gem.summary = "Create and run instances of the Persevere JS Database."
    gem.email = "rheimbuch@gmail.com"
    gem.homepage = "http://github.com/rheimbuch/persvr"
    gem.authors = ["Ryan Heimbuch"]
    
    gem.platform = 'java'
    
    gem.add_dependency 'jettr'
    gem.add_dependency 'thor'
  end
rescue LoadError
  puts "Jeweler no available. Install with: gem install jeweler"
end