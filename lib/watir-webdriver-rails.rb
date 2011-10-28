require 'watir-webdriver'

module WatirWebdriverRails
  class WatirWebdriverRailsError < StandardError; end
  class TimeoutError < WatirWebdriverRailsError; end
 
end

require 'watir-webdriver-rails/rails'
require 'watir-webdriver-rails/driver'
require 'watir-webdriver-rails/browser'
require 'watir-webdriver-rails/rspec'

# start server
RSpec.configure do |config|
  
  config.include WatirWebdriverRails::RSpec, :example_group=>{:file_path=>/spec[\\\/](requests|integration|controllers)/}
  
  config.after(:each) do
    if self.class.include?(WatirWebdriverRails::RSpec)
      browser.clear_cookies
      WatirWebdriverRails.close_browser
    end
  end

  config.before do
    if self.class.include?(WatirWebdriverRails::RSpec)
       WatirWebdriverRails.run_server
       WatirWebdriverRails.initialize_browser
    end
  end

# I would really love to add this hook, but it complains that URL is not valid.
#  config.before(:each) do
#    if self.class.include?(WatirWebdriverRails::RSpec)
#      browser.goto 'about:blank'
#    end
#  end
end
