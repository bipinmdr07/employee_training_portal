# config valid only for current version of Capistrano
#lock '3.9.1'

set :application, 'employeetrainingportal'
set :repo_url, 'git@github.com:bipinmdr07/employee_training_portal.git'

# rvm version in server. Change the rvm ruby if you are using a different rvm ruby version
set :rvm_ruby_version, 'ruby-2.3.1'

set :initial, ENV['initial'] || 'false'


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/application.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


namespace :deploy do
  desc 'Reload application'
  task :reload do
    desc 'Reload app after change'
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command} Nginx."
    task command do
      on roles(:app) do
        execute "sudo service nginx #{command}"
      end
    end
  end

  # after :finishing, 'deploy:update_cron'
  after :publishing, :reload
end

def rvm_prefix
  "#{fetch(:rvm_path)}/bin/rvm #{fetch(:rvm_ruby_version)} do"
end

# These are one time tasks for the first deploy
namespace :setup do
  desc 'Upload database.yml and application.yml files.'
  task :yml do
    on roles(:app) do
      execute "mkdir -p #{shared_path}/config"
      upload! StringIO.new(File.read('config/database.yml')), "#{shared_path}/config/database.yml"
      upload! StringIO.new(File.read('config/application.yml')), "#{shared_path}/config/application.yml"
    end
  end

  desc 'Create the database.'
  task :db_create do
    on roles(:app) do
      within "#{release_path}" do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  desc 'Seed the database.'
  task :db_seed do
    on roles(:app) do
      within "#{release_path}" do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  desc 'reset the database.'
  task :db_reset do
    on roles(:app) do
      within "#{release_path}" do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:reset'
        end
      end
    end
  end


  before 'deploy:starting', 'setup:yml'
  if fetch(:initial) == 'true'
    before 'deploy:migrate', 'setup:db_create'
    after 'deploy:migrate', 'setup:db_seed'
    before 'deploy:assets:precompile', 'deploy:migrate'
  end


  if fetch(:reset) == 'true'
    before 'deploy:migrate', 'setup:db_reset'
    after 'deploy:migrate', 'setup:db_seed'
    before 'deploy:assets:precompile', 'deploy:migrate'
  end

end


