# Set your full path to application.
app_dir = File.expand_path('../../', __FILE__)
shared_dir = File.expand_path('/home/rails/application/shared/', __FILE__)

# Set unicorn options
worker_processes 2
preload_app true
timeout 30

# Fill path to your app
working_directory app_dir

# Set up socket location
listen "#{shared_dir}/sockets/application.sock", :backlog => 64

# Loging
stderr_path "#{shared_dir}/log/application.stderr.log"
stdout_path "#{shared_dir}/log/application.stdout.log"

# Set master PID location
pid "#{shared_dir}/pids/application.pid"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_dir}/Gemfile"
  ENV['RAILS_ENV'] = "production"
end
