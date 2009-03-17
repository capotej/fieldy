require 'rake'
begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "fieldy"
    s.summary = "Read and write fixed width record with ease"
    s.email = "jcapote@gmail.com"
    s.homepage = "http://github.com/jcapote/fieldy"
    s.description = "Declartive DSL for handling fixed width records, read and write with ease"
    s.authors = ["jcapote"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end


require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end


task :default => :test
