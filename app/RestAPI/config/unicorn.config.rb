# This is the configuration for running apps with unicorn.
# See original here: http://projects.puppetlabs.com/projects/1/wiki/Using_Unicorn

worker_processes 1
working_directory '/opt/www/RestAPI'
listen '/tmp/unicorn.RestAPI.sock', :backlog => 2048
timeout 300
pid "/opt/www/RestAPI/unicorn.pid"
client_body_buffer_size 524288

stderr_path '/opt/www/RestAPI/log/stderr.log'
stdout_path '/opt/www/RestAPI/log/stdout.log'

preload_app true

# See http://unicorn.bogomips.org/SIGNALS.html for what this does.
before_fork do |server, worker|
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end


