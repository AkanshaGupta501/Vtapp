require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'

Capybara.run_server = true
Capybara.app_host = "http://catercat-staging.domain4now.com/admin"
Capybara.default_driver = :selenium
