module WatirWebdriverRails
  class << self
    attr_accessor :browser
    
    def initialize_browser
      @browser = Watir::Browser.new(WatirWebdriverRails.driver)
    end
    
    def reset_sessions!
      @browser.clear_cookies
    end
    
  end
end