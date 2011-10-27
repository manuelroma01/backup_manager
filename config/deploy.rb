require 'bundler/capistrano'

# datos servidor produccion
ser :user, 'root'
set :domain, 'r3test.creal.cat'
set :applicationdir '/home/backup_manager'
set :application, "backup_manager"

# control de versiones con git
set :scm, :git
set :repository,  "manel@crealfs02.creal.cat:/var/git/backup_manager.git"
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

# roles
role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

# config deploy
set :deploy_to, applicationdir
set :deploy_via, :export

# otros
default_run_options[:pty] = true

# passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
