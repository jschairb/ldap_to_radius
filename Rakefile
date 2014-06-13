require 'rspec/core/rake_task'
task :default => [:spec]

$LOAD_PATH.push(File.join(File.expand_path(File.dirname(__FILE__)), 'lib'))
require 'ldap_to_radius'

namespace :server do
  desc "Start a server"
  task :start do
    LDAPToRadius.start
  end
end

desc "Run all specs"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = "spec/**/*_spec.rb"
end
