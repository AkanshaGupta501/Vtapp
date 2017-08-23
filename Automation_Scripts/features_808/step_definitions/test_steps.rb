require 'capybara-cucumber'
require 'selenium-webdriver'
require 'capybara'

@browser = Selenium::WebDriver.for :firefox

Given (/^I am on (.+)$/) do |url|
	@browser.visit "http://www.google.com"
end

When (/^I fill in "([^\"]*)" found by "([^\"]*)" with "([^\"]*)"$/) do |value, type, keys|
	@element = @browser.find_element(type, value)
	@element.send_keys keys
end

When (/^I submit$/) do
	@element.submit
end

Then (/^I should see title "([^\"]*)"$/) do |title|
	raise "Fail" if @browser.title != title
end