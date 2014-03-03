require 'recap/recipes/ruby'

settings_yml_path = "config/deploy.yml"
config = YAML::load(File.open(settings_yml_path))

set :application, application = config['production']['application']
set :repository, 'git@github.com:openteam-tusur/push.git'

set :application_user, 'rvmuser'
set :application_home, "/srv/#{application}"
set :remote_user, application_user
server 'push', :app

namespace :deploy do
  desc "Restart the application following a deploy"
  task :restart do
    sudo "/etc/init.d/push-server restart"
  end
end
