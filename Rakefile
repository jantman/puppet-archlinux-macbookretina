require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

# workaround for https://github.com/rodjek/puppet-lint/issues/355
Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  config.fail_on_warnings = true
  config.disable_checks = [
    '80chars',
    'class_inherits_from_params_class',
  ]
  config.ignore_paths = [
    "spec/**/*.pp",
    "pkg/**/*.pp",
    "vendor/**/*.pp",
  ]
end

# task to run all tests
desc "run all tests (lint, metadata, spec, syntax, validate)"
task :test => [:lint, :metadata, :syntax, :validate, :spec]
