require 'coveralls'
Coveralls.wear!

# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

require "link_to_action"

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

class ActionView::TestCase
  include LinkToAction::Helpers
  include MiscHelpers

  def can?(object, ability)
    false
  end

  setup :setup_new_user

  def setup_new_user(options={})
    @user = User.last
  end
end
