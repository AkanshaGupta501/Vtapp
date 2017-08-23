require 'watir-webdriver'
require 'colorize'

browser=Watir::Browser.new

Given(/^Login to facebook website$/)do
    browser.goto "https://www.facebook.com"
end

When(/^Enter the valid email id and password$/)do
    browser.text_field(:name,"email").set("vinsol.com")
    browser.text_field(:name,"pass").set("")
    browser.button(:id,"u_0_q").click
end

Then(/^Login Successful$/)do
    puts "Login InSuccessful"
end
