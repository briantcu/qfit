# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Qfit::Application.initialize!

Rails.logger = Le.new('5df2352c-a7fa-4901-aba4-b13c7aa49882', :debug => true, :local => true)
