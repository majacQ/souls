require "simplecov"

SimpleCov.start do
  add_filter "spec/"

  add_group "CLI", "lib/souls/cli"
end

require "bundler/setup"
require "souls"
require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "./config/souls"
require "fakefs/safe"
require "fakeredis"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with(:rspec) do |c|
    c.syntax = :expect
  end

  config.after(:all) do
    file_paths = ["./app"]
    file_paths.each { |path| FileUtils.rm_rf(path) if Dir.exist?(path) }

    @redis = Redis.new
  end
end
