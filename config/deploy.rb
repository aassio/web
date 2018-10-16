# config valid only for current version of Capistrano
lock "3.8.2"

set :application, "aassio"
set :repo_url, "git@github.com:aassio/web.git"

set :deploy_to, "/home/aassio/#{fetch(:application)}"

set :deploy_via,      :remote_cache
set :ssh_options,     {forward_agent: true}
set :use_sudo,        false
set :keep_releases, 10


# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/unicorn.rb', 'config/master.key', 'config/database.yml'

# Default value for linked_dirs is []
append :linked_dirs,  'log', 'pids', 'sockets', 'vendor/bundle', 'storage'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5



set :rvm_type, :user
# set :rvm_custom_path, '~/.rvm'  # only needed if not detected
set :rvm_ruby_version, '2.3.3'

# set :rollbar_token, 'b910340a8cdf4357acbe1360dc11141b'
# set :rollbar_env, Proc.new { fetch :stage }
# set :rollbar_role, Proc.new { :app }

set :assets_roles, [:web, :app]


after 'deploy:publishing', 'deploy:restart'

namespace :deploy do

  desc 'Start unicorn'
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{current_path}; ~/.rvm/bin/rvm 2.3.3 do bundle exec unicorn -c config/unicorn.rb -E #{fetch :rails_env} -D"
    end
  end

  desc 'Stop unicorn'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s QUIT `cat #{shared_path}/pids/unicorn.pid`"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute "kill -s USR2 `cat #{shared_path}/pids/unicorn.pid`"
    end
  end

end
