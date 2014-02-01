namespace :spec do
  task :js do
    system("cd spec/dummy && bundle exec rake jasmine:ci") or exit!(1)
  end
end