require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'uri'

Capybara.run_server = true
Capybara.app_host = "http://catercat-staging.domain4now.com"
Capybara.default_driver = :selenium
