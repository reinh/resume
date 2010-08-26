require 'rake/testtask'
require 'fileutils'

task :default => ['test']

GEM_NAME = "danmayer-resume"

desc "run sintra server locally"
task :run do
  exec "ruby resume.rb"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = GEM_NAME
    gemspec.summary = "Resume gem"
    gemspec.description = "A gem for Dan Mayer's resume"
    gemspec.email = "dan@mayerdan.com"
    gemspec.homepage = "http://github.com/danmayer/Resume"
    gemspec.authors = ["Dan Mayer"]
    gemspec.executables = [GEM_NAME]
    gemspec.add_development_dependency "jeweler"
    gemspec.add_dependency "main"
    gemspec.add_dependency "maruku"
    gemspec.add_dependency "sinatra", '~> 1.0'
    gemspec.add_dependency "erubis"
    gemspec.add_dependency 'less'
    gemspec.add_dependency 'launchy'
    gemspec.add_dependency 'rdiscount'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end

task :build => [:generate_exe]
namespace :heroku do

  desc "create a heroku project for your resume"
  task :create do
    unless ENV.include?("name")	
      raise "usage: rake heroku:create name=PROJECT_NAME # example danmayer-resume\n" 
    end
    project_name = ENV['name']
    puts "creating heroku project #{project_name}"
    puts `heroku create #{project_name}`
  end
end

task :render do
  sh "ronn --pipe -5 data/resume.md |grep -v 'dt.flush' > index.html"
end

task :commit do
  sh "git commit -am 'Made some changes to my resume, init'"
end

namespace :deploy do
  desc "Deploy to Heroku."
  task :heroku => [:render, :commit] do
    sh "git push heroku master"
  end

  desc "Deploy to Github pages."
  task :github => [:render, :commit] do
    # this assumes you have made a remote called github
    # `git remote add github git@github.com:username/username.github.com.git`
    # this should push your resume to http://username.github.com
    sh "git push github master"
  end
end
