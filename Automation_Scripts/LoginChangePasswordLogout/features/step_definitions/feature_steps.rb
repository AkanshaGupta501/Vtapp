Given(/^I am on CaterCat Page$/) do
    visit'/'
    click_link('Login / Signup')
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

Then(/^I should see User Name$/) do 
    anchor_link = find(:xpath, "//a[@class='dropdown-toggle']") 
    user_name = anchor_link.native.text
    puts "Hello, Admin! #{user_name}"

end

Then(/^I click logout$/) do 
   visit '/logout'
end