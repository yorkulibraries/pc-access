ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all

  # Add more helper methods to be used by all tests here...
  # include ActionDispatch::TestProcess
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase

  def log_user_in(user)
    session[:user_id] = user.id
  end

end
