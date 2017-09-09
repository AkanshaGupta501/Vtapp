require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'data_magic'
require 'site_prism'
require 'spec_helper.rb'
require 'byebug'

include DataMagic
Dir.glob("./spec/support/*.rb").each{|f| ; require f}
include CustomTestData

include WaitForAjax
include PageHelper
Dir.glob("./spec/features/lib/*.rb").each{|f| ; require f}


DataMagic.yml_directory = "spec/features/data"
Dir.glob("/*.yml").each{|f| ; DataMagic.load f}


Capybara.register_driver :selenium do |app|  
  profile = Selenium::WebDriver::Chrome::Profile.new
  Capybara::Selenium::Driver.new(app, browser: :chrome, :profile => profile)
end
Capybara.javascript_driver = :selenium
Capybara.configure do |config|
  config.always_include_port = true
  config.app_host = "https://staging.brodboksen.no/"
  config.default_max_wait_time = 5 # seconds
  config.default_driver        = :selenium
  clear_session_storage: false
end

