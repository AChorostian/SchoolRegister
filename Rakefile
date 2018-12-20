require 'rspec/core/rake_task'
require 'rake/testtask'

RSpec::Core::RakeTask.new(:spec) do |parameter|
  parameter.rspec_opts = '-fd'
end

 Rake::TestTask.new(:minitest) do |t|
   t.libs << "test"
   t.libs << "lib"
   t.test_files = FileList['test/*_test.rb']
   t.warning = false
 end

task default: [:spec,:minitest]
