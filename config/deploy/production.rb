role :app, %w{148.251.233.13}
role :web, %w{148.251.233.13}
role :db,  %w{148.251.233.13}

set :stage, :production

set :log_level,   :info

set :ssh_options, {
    user: 'aassio',
    forward_agent: true,
    port: 21212
}

set :application, 'aassio'
set :deploy_to, "/home/aassio/#{fetch(:application)}"
set :branch, 'production'
set :rails_env, 'production'

set :default_environment, {
    'RUBY_VERSION' => 'ruby 2.3.3'
}

