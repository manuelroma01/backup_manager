require 'bundler/capistrano'

# buen ejemplo en: https://gist.github.com/157958

## Aplicacion
set :application, "manager"
set :deploy_to, "/home/backup_manager"

## Server
set :user, "webserver"
set :domain, "r3test.creal.cat"

## roles
role :web, domain                         # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

## Settings
default_run_options[:pty] = true

## git
set :scm, :git
set :repository, "manel@crealfs02.creal.cat:/var/git/backup_manager.git"
set :branch, 'master'

# passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  namespace :db do
    desc "Populates the Production Database"
    task :seed do
      puts "\n\n=== Populating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:seed RAILS_ENV=production"
    end
  end
end

