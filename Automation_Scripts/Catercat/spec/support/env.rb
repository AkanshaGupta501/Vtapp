require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'capybara/rspec'
require 'site_prism'
require 'selenium-webdriver'
require 'data_magic'
require 'spec_helper.rb'
include DataMagic

DataMagic.yml_directory = "spec/features/data"
Dir.glob("/*.yml").each{|f| DataMagic.load f}
Dir.glob("./spec/features/lib/*.rb").each{|f| ; require f}
Dir.glob("./spec/support/*.rb").each{|f| require f}

Capybara.javascript_driver = :selenium
Capybara.configure do |config|
  config.always_include_port = true
  config.app_host = "http://catercat-staging.domain4now.com/"
  config.default_max_wait_time = 5 # in seconds
  config.default_driver        = :selenium
end