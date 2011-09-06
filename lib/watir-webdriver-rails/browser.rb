module WatirWebdriverRails
  class << self
    attr_accessor :browser
    
    def initialize_browser
      @browser = Watir::Browser.new(WatirWebdriverRails.driver)
    end
    
  end
end