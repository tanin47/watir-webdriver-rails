require 'watir-webdriver'

module WatirWebdriverRails
  class WatirWebdriverRailsError < StandardError; end
  class TimeoutError < WatirWebdriverRailsError; end
 
end

require 'watir-webdriver-rails/rails'
require 'watir-webdriver-rails/driver'
require 'watir-webdriver-rails/browser'
# start server
RSpec.configure do |config|
  config.before(:suite) do
     WatirWebdriverRails.run_server
     
     Watir::Browser.initialize_browser
     let(:browser) { Watir::Browser.browser }
  end
end