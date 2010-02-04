require 'rake/clean'

CLOBBER.include "vendor/persevere"

task :clean do
  if File.exist? "vendor/persevere"
    cd "vendor/persevere" do
      sh "ant clean"
    end
  end
end

desc "Builds and prepares persevere jars and persevere base directory."
task :persevere => ['persevere:lib','persevere:resource']

namespace :persevere do

  
  PERSVR_SVN = "http://persevere-framework.googlecode.com/svn/branches/1.0"
  
  directory "vendor"
  file "vendor/persevere" => ['vendor'] do |t|
    sh "svn co #{PERSVR_SVN} #{t.name}"
  end
  
  file "vendor/persevere/builds/persevereJ2EE" => "vendor/persevere" do
    cd "vendor/persevere" do
      sh "ant pkgPersevereJ2EE"
    end
  end
  

  
  # file "vendor/persevere/builds/persevereJ2EE/WEB-INF/lib" => 'vendor/persevere/builds/persevereJ2EE'
  # file "lib/persvr/jars" => "vendor/persevere/builds/persevereJ2EE/WEB-INF/lib" do |t|
  #   cp_r t.prerequisites.first, t.name
  # end
  # 
  # task :lib => 'lib/persvr/jars'
  task :lib
  file "resource/persevere_home" => "vendor/persevere/builds/persevereJ2EE" do |t|
    cp_r t.prerequisites.first, t.name
    rm_rf FileList["#{t.name}/*"].exclude("#{t.name}/WEB-INF")
    touch "#{t.name}/WEB-INF/jslib/.empty_directory"
  end
  task :resource => "resource/persevere_home"
  
  # directory "resource/persevere_home"
  # file "vendor/persevere/builds/persevereJ2EE/etc" => 'vendor/persevere/builds/persevereJ2EE'
  # file "resource/persevere_home/etc" => ['vendor/persevere/builds/persevereJ2EE/etc', 'resource/persevere_home'] do |t|
  #   cp_r t.prerequisites.first, t.name
  # end
  # 
  # directory "resource/persevere_home/WEB-INF"
  # file "vendor/persevere/builds/persevereJ2EE/WEB-INF/web.xml.generic" => "vendor/persevere/builds/persevereJ2EE"
  # file "resource/persevere_home/WEB-INF/web.xml" => ['vendor/persevere/builds/persevereJ2EE/WEB-INF/web.xml.generic', 'resource/persevere_home/WEB-INF'] do |t|
  #   cp_r t.prerequisites.first, t.name
  # end
  # 
  # file 'vendor/persevere/builds/persevereJ2EE/WEB-INF/config' => 'vendor/persevere/builds/persevereJ2EE'
  # file "resource/persevere_home/WEB-INF/config" => ['vendor/persevere/builds/persevereJ2EE/WEB-INF/config', 'resource/persevere_home/WEB-INF'] do |t|
  #   cp_r t.prerequisites.first, t.name
  # end
  # 
  # directory "resource/persevere_home/WEB-INF/data"
  # directory "resource/persevere_home/WEB-INF/jslib"
  # directory "resource/persevere_home/WEB-INF/tests"
  # 
  # task :resource => [
  #   "resource/persevere_home/etc",
  #   "resource/persevere_home/WEB-INF",
  #   "resource/persevere_home/WEB-INF/web.xml",
  #   "resource/persevere_home/WEB-INF/config",
  #   "resource/persevere_home/WEB-INF/data",
  #   "resource/persevere_home/WEB-INF/jslib",
  #   "resource/persevere_home/WEB-INF/tests"
  #   ]
    
    CLEAN.include "resource/persevere_home"
end