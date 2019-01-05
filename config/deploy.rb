# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "employeetrainingportal"
set :repo_url, "git@github.com:bipinmdr07/employee_training_portal.git"

# rvm version in server. Change the rvm ruby if you are using a different rvm ruby version
set :rvm_ruby_version, 'ruby-2.3.1'

#set :deploy_to, '/home/ec2-user/projects/qa/ETP/'

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

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 5

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug


# Default value for :linked_files is []
 set :linked_files, %w{config/database.yml config/application.yml}

# # Default value for linked_dirs is []
# set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


# Uncomment the following to require manually verifying the host key before first deploy.
set :ssh_options, :compression => false, verify_host_key: :secure
namespace :deploy do
  desc 'Reload application'
  task :reload do
    desc 'Reload app after change'
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
     # execute :touch, release_path.join('tmp/restart.txt')
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
  after :publishing, :reload
end

# namespace :cache do
#   task :clear do
#     on roles(:app) do |host|
#       with rails_env: fetch(:rails_env) do
#         within current_path do
#           execute :bundle, :exec, "rake cache:clear"
#         end
#       end
#     end
#   end
# end

# These are one time tasks for the first deploy
namespace :setup do
  desc 'Upload database.yml and application.yml files.'
  task :yml do
    on roles(:app,:rake_task_runner) do
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

  desc 'Generate the api secret key'
  task :api_key_gen do
    on roles(:app) do
      within "#{release_path}" do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'generate:api_key'
        end
      end
    end
  end

  # desc 'Generate the swagger api documentation'
  # task :generate_api_docs do
  #   on roles(:app) do
  #     within "#{release_path}" do
  #       with rails_env: fetch(:rails_env) do
  #         execute :rake, 'swagger:docs'
  #       end
  #     end
  #   end
  # end

  before 'deploy:starting', 'setup:yml'
  if fetch(:initial) == 'true'
    before 'deploy:migrate', 'setup:db_create'
    after 'deploy:migrate', 'setup:db_seed'
    #after 'deploy:migrate', 'setup:api_key_gen'
    before 'deploy:assets:precompile', 'deploy:migrate'
  end

  # after 'deploy:update', 'cache:clear'


  if fetch(:reset) == 'true'
    before 'deploy:migrate', 'setup:db_reset'
    after 'deploy:migrate', 'setup:db_seed'
    #after 'deploy:migrate', 'setup:api_key_gen'
    before 'deploy:assets:precompile', 'deploy:migrate'
  end
  #after 'deploy:finished', 'aws_receive_message:restart'
  #after 'deploy:finished', 'setup:generate_api_docs'
  #after 'deploy:finished', 'sidekiq:restart'

end
