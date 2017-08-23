require 'selenium-webdriver'
require 'colorize'
require 'rspec/expectations'

browser=Selenium::WebDriver.for :firefox
Given(/^Goto login page$/)do
    browser.get "http://staging.trestique.com/login"
    
    #browser.find_element('.modal_close close',:text => 'x').click
    #browser.find(".modal_close close").click
    #browser.find("#myModal").should_be_checked
    #browser.window.showModalDialog('staging.trestique.com/login.htm', self)
    #browser.execute_script("window.dialogArguments!=null?false:true")
    #browser.execute_script(:id,"myModal").modal.set("hide")
end

When(/^Enter valid email and password$/)do
    #browser.get "http://staging.trestique.com/login"
    browser.find_element(:class,'modal_close close').click
    email=browser.find_element(:name,"email")
    email.send_keys("amit.aggarwal@vinsol.com")
    submitbtn=browser.find_element(:name,"submit")
    submitbtn.click
    password=browser.find_element(:id,"spree_user_password")
    password.send_keys("123456")
    loginbtn=browser.find_element(:name,"commit")
    loginbtn.click
end

Then(/^Login successful$/)do
puts "Login Successful"
end