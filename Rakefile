require 'rake'
require 'cucumber/rake/task'

desc "Start the application"
task :default do
  start_application!
end

Cucumber::Rake::Task.new(:features) do |task|
  task.cucumber_opts = "features --format pretty"
end

Cucumber::Rake::Task.new(:report, "Run Cucumber features for report") do |task|
  task.cucumber_opts = "features_for_report --format pretty"
end

def start_application!
  stop_application! if application_running?

  fail "Failed to start app" unless system "thin start -d -p 3000" 
  wait_until do
    application_running?
  end
end

def stop_application!
  system "kill -9 #{application_process_id}"
end

def application_running?
  not `lsof -i tcp:3000 | grep LISTEN`.empty?
end

def application_process_id
  `lsof -i tcp:3000 | grep LISTEN`.split[1]
end

def wait_until timeout=60
  start_time = Time.now
  until Time.now > start_time + timeout
    return if yield
    sleep 0.5
  end
  raise "action took too long"
end
