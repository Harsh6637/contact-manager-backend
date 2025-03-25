ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Load all Ruby files in the lib/ directory
Dir[Rails.root.join('lib/**/*.rb')].each { |file| require file }

# Require DatabaseCleaner for maintaining clean test state
require 'database_cleaner/active_record'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Configure DatabaseCleaner to maintain clean database state
    DatabaseCleaner.strategy = :transaction
    setup { DatabaseCleaner.start }    # Start cleaning the database before each test
    teardown { DatabaseCleaner.clean } # Clean up after each test

    # Add more helper methods to be used by all tests here...
  end
end
