require 'rake/testtask'

task :default => [:build]

task :build do
	# run sinatra locally...
end

namespace :test do
  Rake::TestTask.new(:rack) do |t|
    t.libs << "test"
    t.pattern = "test/**/*_test.rb"
    t.verbose = true
  end
  Rake::Task["test:rack"].comment = "Run the Rack::Test tests in test/rack"
end

desc "Deploy to Heroku."
task :deploy do
	require 'heroku'
	require 'heroku/command'
	user, pass = File.read(File.expand_path("~/.heroku/credentials")).split("\n")
	heroku = Heroku::Client.new(user, pass)

	cmd = Heroku::Command::BaseWithApp.new([])
	remotes = cmd.git_remotes(File.dirname(__FILE__) + "/../..")

	remote, app = remotes.detect {|key, value| value == (ENV['APP'] || cmd.app)}

	if remote.nil?
		raise "Could not find a git remote for the '#{ENV['APP']}' app"
	end

	`git push #{remote} master`

	heroku.restart(app)
end
