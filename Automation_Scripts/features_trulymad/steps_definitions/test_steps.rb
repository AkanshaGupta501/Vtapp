require 'selenium-webdriver'
require 'colorize'
require 'rspec/expectations'

browser=Selenium::WebDriver.for :firefox
Given(/^Goto login page$/)do
    browser.navigate.to "about:newtab"
    browser.get "http://trulyMAD:H0ust0n@prep.trulymadsupplies.com/"
    browser.get "http://prep.trulymadsupplies.com/login"
   
end

When(/^Enter valid email and password$/)do
    login_id=browser.find_element(:id, "login")
    login_id.find_element(:id,"spree_user_email").send_keys("akanshagupta1@yahoo.com")
    login_id.find_element(:id, "spree_user_password").send_keys("123456")
    login_id.find_element(:name, "button").click
    puts "Login Successful"
    
end

Then(/^Login successful$/)do
    browser.get "http://prep.trulymadsupplies.com/logout"
    #header=browser.find_element(:id,"header")
    #header_table=header.find_element(:class,"header-table")
    #header_table.find_element(:link_text, "Logout").click
    puts "Logout Successful"
end