require 'recap/recipes/ruby'
require 'yaml'

settings_yml_path = "config/deploy.yml"
config = YAML::load(File.open(settings_yml_path))

set :application, application = config['production']['application']
set :repository, 'git@github.com:openteam-tusur/push.git'

set :application_user, 'rvmuser'
set :application_home, "/srv/#{application}"
set :remote_user, application_user
set :deploy_to, "#{application_home}/current"
set :bundle_path, "#{application_home}/shared/bundle"

server 'push', :app

namespace :deploy do
  desc "Restart the application following a deploy"
  task :restart do
    sudo "/etc/init.d/push-server restart"
  end
end
