module WatirWebdriverRails
  class << self
    attr_accessor :browser,:browser_initialized
    
    def initialize_browser
      
      return if @browser_initialized == true

      @browser = Watir::Browser.new(WatirWebdriverRails.web_driver)
      
      @browser.class_eval do
         alias_method :old_goto,:goto
         
         def goto(*args)
           
           if !args[0].match(/^(https?"|about):/)
              args[0] = "http://#{WatirWebdriverRails.host}:#{WatirWebdriverRails.port}#{args[0]}"
           end
           
           old_goto(*args)      
         end
      end
      
      @browser_initialized = true
    end
    
    def close_browser
      @browser.close if @browser_initialized == true
      @browser_initialized = false
    end
     
  end
end
