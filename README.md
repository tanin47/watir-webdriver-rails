watir-webdriver-rails
===============

watir-webdriver-rails provides a dead-simple integration test of Watir with Rails 3.

Installation
--------

In your Gemfile, drop the below line

``
gem 'watir-webdriver-rails'
``

and type:

``
bundle install
``

from your command line and Rails's root folder

How to use
-------

In your spec_helper.rb, please place the below lines:
(watir-webdriver-rails uses RSpec as the testing framework)

```ruby

require 'rspec/rails'
require 'watir-webdriver-rails'

WatirWebdriverRails.host = "localhost"
WatirWebdriverRails.port = 57124

```

In your integration test file, it should look something like this:

```ruby

require 'spec_helper'

describe "Test something" do

	it "should go to some page and fill textbox" do
	
		browser.goto "/member"
		
		browser.text_field(:id=>"first_name").set "Tanin"
		browser.text_field(:id=>"last_name").set "Na Nakorn"
		
		browser.text_field(:id=>"first_name").value.should == "Tanin"
	end
end

```

browser is of type Watir::Browser. You may interact with it freely.
See http://rubydoc.info/gems/watir-webdriver/0.3.2/Watir/Browser

Dependencies
------------

* watir-webdriver
* rspec

Development
-----------------------------

* Fork the project.
* Add features or fix bugs
* Add test cases for it
* Send me a pull request

Please try running all the test cases first by going to the root folder and type:

``
bundle exec rspec spec/*
``


License
---------

There are parts which are copied from capybara and capybara-firebug gems. Please also be aware of their licenses.
Other than that, you can do anything with it.

Author
---------
Tanin Na Nakorn
