# encoding: utf-8
require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../rails/config/environment", __FILE__)

require 'rspec/rails'
#require 'watir-webdriver-rails'
require File.expand_path("../../lib/watir-webdriver-rails", __FILE__)

WatirWebdriverRails.host = "localhost"
WatirWebdriverRails.port = 57124
WatirWebdriverRails.close_browser_after_finish = true

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


RSpec.configure do |config|

end



