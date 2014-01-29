# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'spork', :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('Gemfile')
  watch('Guardfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch(%r{^spec/support/.+\.rb$})
  watch(%r{^lib/digital_opera/(.+)\.rb$}) { :rspec }
end

guard :rspec, :all_after_pass => false, :all_on_start => false, :cli => '--drb' do
  watch(%r{^spec/.+_spec\.rb$})
end
