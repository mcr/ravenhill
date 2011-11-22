set :application, "ravenhill"
set :logname, "#{ENV['LOGNAME']}"
set :repository,  "git+ssh://#{logname}@code.credil.org/git/ravenhill"

set :scm, :git

role :web, "snapper.sandelman.ca"
role :app, "snapper.sandelman.ca"
role :db,  "snapper.sandelman.ca", :primary => true

set :user, :ravenhill
set :ssh_options, { :forward_agent => true }
set :use_sudo, false
set :git_enable_submodules, true
set :deploy_to, "/data/#{user}/#{application}"

namespace :deploy do
  task :update_database_yml, :roles => [:app,:web] do
    db_config = "/data/#{user}/database.yml"
    #prod_config = "/home/#{user}/production.rb"
    run "cp #{db_config}   #{release_path}/config/database.yml"
    #run "cp #{prod_config} #{release_path}/config/environments"
    releasenum=File.basename(release_path)
    run "echo '$ReleaseNum = \"#{releasenum}\"' >#{release_path}/config/initializers/releasenum.rb"
    puts "Ran update database_yml"
  end
  after "deploy:update_code", "deploy:update_database_yml"
end

