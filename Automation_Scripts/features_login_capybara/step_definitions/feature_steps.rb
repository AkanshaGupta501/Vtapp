#Selenium::WebDriver.for :firefox

Given(/^I am on CaterCat Admin Page$/) do
    visit'/login'
end

When(/^I enter "(.*)" for login with "(.*)"$/) do |field, value|
    fill_in(field,:with => value)
end

Then(/^I enter "(.*)" as password for login "(.*)"$/) do |field, value|
    fill_in(field,:with => value)
end

Then(/^I click "(.*)" button$/) do |button|
    click_button(button)
end

Then(/^I should see "(.*)"$/) do |text|
    page.has_content?(text)
    puts "Login Successful"  
end

Then(/^I should logout$/) do
	click_link('CaterCat Admin')
	click_link('Logout')
end