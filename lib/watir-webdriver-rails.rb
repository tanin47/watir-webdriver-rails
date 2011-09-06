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
  
  config.include WatirWebdriverRails::RSpec
  
  config.before(:suite) do
     WatirWebdriverRails.run_server
     WatirWebdriverRails.initialize_browser
     
     WatirWebdriverRails.browser.class_eval do
       alias_method :old_goto,:goto
       
       def goto(*args)
         
         if !args[0].match(/^https?:/)
            args[0] = "http://#{WatirWebdriverRails.host}:#{WatirWebdriverRails.port}#{args[0]}"
         end
         
         old_goto(*args)      
       end
     end
  end
end