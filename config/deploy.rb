require 'yaml'
require 'net/ssh/proxy/command'

config = YAML::load(File.open('config/deploy.yml'))

lock '3.8.2'

stage = fetch(:stage)
stage = 'stage' if stage == '' || stage == nil
config = config[stage.to_s]
config.each do |k, v|
  set k.to_sym, v
end

set :application, fetch(:application)

set :repo_url, `git config --get remote.origin.url`.chomp
set :user, `git config --get user.name`.chomp
set :branch, 'master'

set :deploy_to, "/srv/#{fetch(:application)}"

set :log_level, :info
set :db_local_clean, true
set :db_remote_clean, true
set :bundle_binstubs, -> { shared_path.join('bin')  }

append :linked_dirs, 'bin', '.bundle', 'log', 'tmp/cache', 'tmp/pids', 'tmp/sockets'

role :app, [fetch(:domain)]
role :web, [fetch(:domain)]
role :db, [fetch(:domain)]

server fetch(:domain), user: 'rvmuser', roles: %w{app web},
  ssh_options: {
  forward_agent: true,
  keys: '~/.ssh/id-rsa.pub',
  proxy: Net::SSH::Proxy::Command.new("ssh -o StrictHostKeyChecking=no #{fetch(:gateway)} -W %h:%p")
} if fetch(:gateway)

desc 'Restart the application following a deploy'
task 'push-server:restart' do
  on roles(:app) do
    sudo '/etc/init.d/push-server restart'
  end
end

after 'deploy:publishing', 'push-server:restart'

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
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5
