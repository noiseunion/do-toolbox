namespace :spec do
  task :js do
    system("ruby ./tasks/build_js_specs.rb") or exit!(1)
  end
end