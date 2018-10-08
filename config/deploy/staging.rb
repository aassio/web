role :app, %w{148.251.233.13}
role :web, %w{148.251.233.13}
role :db,  %w{148.251.233.13}

set :stage, :staging

set :log_level,   :info

set :ssh_options, {
    user: 'aassio',
    forward_agent: true,
    port: 21212
}

set :application, 'aassio_stage'
set :deploy_to, "/home/aassio/#{fetch(:application)}"
set :branch, 'master'
set :rails_env, 'staging'

set :default_environment, {
    'RUBY_VERSION' => 'ruby 2.3.3'
}

