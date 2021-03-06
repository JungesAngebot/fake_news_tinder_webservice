# config valid only for Capistrano 3.2.1
lock '3.7.1'

set :application, 'fakenewsquiz'
set :repo_url, 'https://github.com/JungesAngebot/fake_news_tinder_webservice.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10

# set :ssh_options, {
#     keys: %w(~/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey)
# }

set :stages, ['sid', 'staging', 'production']

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)

set :linked_dirs, fetch(:linked_dirs, []).push(*%w(public/uploads pids log manual_uploads))

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      upload! 'config/application.yml', release_path.join('config/application.yml')
      execute :mkdir, '-p', release_path.join('tmp')
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before :migrate, :update_envs

  task :update_envs do
    on roles(:app) do
      upload! 'config/application.yml', release_path.join('config/application.yml')
    end
  end
end

