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

Then(/^I should see Admin Name$/) do 
    anchor_link = find(:xpath, "//a[@class='dropdown-toggle']") 
    admin_name = anchor_link.native.text
    puts "Hello, Admin! #{admin_name}"

end

Then(/^I click logout$/) do 
   visit '/logout'
end