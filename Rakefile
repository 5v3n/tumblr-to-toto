# 
# To change this template, choose Tools | Templates
# and open the template in the editor.
 
require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'
#require File.join(File.dirname(__FILE__), 'lib', 'tumblr_to_toto')
$:.unshift File.join(File.dirname(__FILE__),'lib')
require 'tumblr_to_toto'

spec = Gem::Specification.new do |s|
  s.name = 'tumblr-to-toto'
  s.homepage = 'http://github.com/5v3n/tumblr-to-toto'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md', 'LICENSE']
  s.summary = 'Convert exported Tumblr blog posts into toto blog posts.'
  s.description = s.summary
  s.author = 'Sven Kraeuter'
  s.email = 'mail@5v3n.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Rake::GemPackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README.md', 'LICENSE', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README.md" # page to start on
  rdoc.title = "TumblrToToto Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

task :convert_file, :filename do |t, args|
  if args.filename
    puts "Converting file #{args.filename}..."
    converter = TumblrToToto.new(args.filename)
    converter.to_file
    puts "...done."
  end
end

task :convert_directory, :dirname do |t, args|
  if args.dirname
  puts "Converting directory #{args.dirname}..."
  converter = TumblrToToto.new()
  converter.from_dir("#{args.dirname}")
  puts "... done."
  end
end

