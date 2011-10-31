require 'bundler/capistrano'

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
set :branch, 'autorizacion'

# passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

## datos servidor produccion
#set :user, 'webserver'
#set :scm_passphrase, "20creal11"
#set :domain, 'r3test.creal.cat'
#set :applicationdir, '/home/backup_manager'
#set :application, "r3test.creal.cat"

## control de versiones con git
#set :scm, :git
#set :repository, "manel@crealfs02.creal.cat:/var/git/backup_manager.git"
#set :branch, 'autorizacion'
#set :git_shallow_clone, 1
#set :scm_verbose, true

## roles
#role :web, domain                         # Your HTTP server, Apache/etc
#role :app, domain                          # This may be the same as your `Web` server
#role :db,  domain, :primary => true # This is where Rails migrations will run

## config deploy
#set :deploy_to, applicationdir
#set :deploy_via, :remote_cache

## otros
#default_run_options[:pty] = true

## passenger
#namespace :deploy do
#  task :start do ; end
#  task :stop do ; end
#  task :restart, :roles => :app, :except => { :no_release => true } do
#    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#  end
#end
