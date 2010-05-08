require 'rake/testtask'

task :default => ['test:all']

task :build do
	# run sinatra locally...
end

namespace :test do
  desc "run all tests"
  task :all do
    Rake::Task['test:rack'].invoke
    Rake::Task['test:unit'].invoke
  end

  desc "run rack tests"
  Rake::TestTask.new(:rack) do |t|
    t.libs << "test"
    t.pattern = "test/rack/**/*_test.rb"
    t.verbose = true
  end

  desc "run unit tests"
  Rake::TestTask.new(:unit) do |t|
    t.libs << "test"
    t.pattern = "test/unit/**/*_test.rb"
    t.verbose = true
  end
end

desc "render github index page, which can be displayed at user.github.com"
task :render_for_github do	
    require File.join(File.dirname(__FILE__), 'resume_gem')
    resume = Resume.new('resume.yml')
    resume.write_html_and_css_to_disk('./')
end

namespace :deploy do
  desc "Deploy to Heroku."
  task :heroku do
    # 	require 'heroku'
    # 	require 'heroku/command'
    # 	user, pass = File.read(File.expand_path("~/.heroku/credentials")).split("\n")
    # 	heroku = Heroku::Client.new(user, pass)

    # 	cmd = Heroku::Command::BaseWithApp.new([])
    # 	remotes = cmd.git_remotes(File.dirname(__FILE__) + "/../..")
    
    # 	remote, app = remotes.detect {|key, value| value == (ENV['APP'] || cmd.app)}
    
    # 	if remote.nil?
    # 		raise "Could not find a git remote for the '#{ENV['APP']}' app"
    # 	end
    
    # 	`git push #{remote} master`
    
    # 	heroku.restart(app)
    `git push heroku master`
  end

  desc "Deploy to Github pages."
  task :github => [:render_for_github] do
    # this assumes you have made a remote called github
    # `git remote add github git@github.com:username/username.github.com.git`
    # this should push your resume to http://username.github.com
    `git push github master`
  end
end

desc "render github index page, which can be displayed at user.github.com"
task :render_for_github do	
    require File.join(File.dirname(__FILE__), 'resume_gem')
    resume = Resume.new('resume.yml')
    puts "writing resume github index files to disk"
    resume.write_html_and_css_to_disk('./')
end
