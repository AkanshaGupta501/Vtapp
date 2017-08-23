
require 'selenium-webdriver'

browser = Selenium::WebDriver.for :firefox

Given (/^I am on the Guru99 homepage$/)do
browser.get "http://demo.guru99.com"
end

When (/^enter details for registration$/)do
    email_field=browser.find_element(:name,"emailid")
    email_field.send_keys("guru99@gmail.com")
    loginbtn=browser.find_element(:name,"btnLogin")
    loginbtn.click
end

Then(/^login successful is shown$/)do
    puts "login Successful"
end

When(/^enter blank details for Register$/)do
    browser.text_field(:name,"emailid").set("")
    browser.button(:name,"btnLogin").click
end

Then(/^error email shown$/)do
     puts "invalid email"
 end