require 'rspec/core'
require 'uri'
require 'net/http'

module WatirWebdriverRails

  class Identify
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["PATH_INFO"] == "/__identify__"
        [200, {}, [@app.object_id.to_s]]
      else
        @app.call(env)
      end
    end
  end

  class << self
    attr_accessor :host, :port, :server_boot_timeout, :app
    
    
    
    def run_server
      
      @app = Rack::Builder.new {
        map "/" do
          if Rails.version.to_f >= 3.0
            run Rails.application  
          else # Rails 2
            use Rails::Rack::Static
            run ActionController::Dispatcher.new
          end
        end
      }.to_app
      
      Thread.new do
        begin
          require 'rack/handler/thin'
          Thin::Logging.silent = true
          Rack::Handler::Thin.run(Identify.new(app), :Port => @port)
        rescue LoadError
          require 'rack/handler/webrick'
          Rack::Handler::WEBrick.run(Identify.new(app), :Port => @port, :AccessLog => [], :Logger => WEBrick::Log::new(nil, 0))
        end
      end

      timeout(@server_boot_timeout) do
        if responsive? 
          true 
        else 
          sleep(0.5)
          false 
        end
      end
    end
    
    
    def responsive?
      res = Net::HTTP.start("127.0.0.1", @port) { |http| http.get('/__identify__') }
    
      if res.is_a?(Net::HTTPSuccess) or res.is_a?(Net::HTTPRedirection)
        return res.body == @app.object_id.to_s
      end
    rescue Errno::ECONNREFUSED, Errno::EBADF
      return false
    end
  end
  
end