require 'watir-webdriver'

module WatirWebdriverRails

  @driver = :firefox

  class << self
    def web_driver
      driver = case @driver
        when :firefox
          profile = Selenium::WebDriver::Firefox::Profile.new
          profile.enable_firebug
          Selenium::WebDriver.for(:firefox, { :profile => profile })
        when :chrome
          profile = Selenium::WebDriver::Chrome::Profile.new
          profile['download.prompt_for_download'] = false
          switches = %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-extensions --incognito --no-default-browser-check --no-process-singleton-dialog --no-message-box ---no-startup-window]
          Selenium::WebDriver.for :chrome, :profile => profile, :switches => switches
        else
          raise "Invalid dirver: " + @driver.to_s
      end

      return driver
    end
  end

  # Copied from capybara-firebug
  class Selenium::WebDriver::Firefox::Profile
    def self.firebug_version
      @firebug_version ||= '1.7.3'
    end

    def self.firebug_version=(version)
      @firebug_version = version
    end

    def enable_firebug(version = nil)
      version ||= Selenium::WebDriver::Firefox::Profile.firebug_version
      #add_extension(File.expand_path("../firebug/firebug-1.7.3.xpi", __FILE__))
      add_extension(File.expand_path("../firebug/firebug-1.8.1.xpi", __FILE__))

      # Prevent "Welcome!" tab
      self["extensions.firebug.currentVersion"] = "999"

      # Enable for all sites.
      self["extensions.firebug.allPagesActivation"] = "on"

      # Enable all features.
      ['console', 'net', 'script'].each do |feature|
        self["extensions.firebug.#{feature}.enableSites"] = true
      end

      # Closed by default.
      self["extensions.firebug.previousPlacement"] = 3
    end
  end

end
