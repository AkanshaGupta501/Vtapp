
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

Then(/^I click add new user link "(.*)"$/) do |tab_link|
	click_link("Users")
	click_link(tab_link)
end

Then(/^I enter user firstname field "(.*)" as "(.*)"$/) do |firstname, value|
	fill_in(firstname, :with => value)
end

Then(/^I enter user lastname field "(.*)" as "(.*)"$/) do |lastname, value|
	fill_in(lastname, :with => value)
end

Then(/^I enter user "(.*)" id as "(.*)"$/) do |email, value|
	fill_in(email, :with => value)
end

Then(/^I select city as "(.*)" from "(.*)" dropdown$/) do |city_name, select_option|
	select(city_name, :from => select_option)
end

Then(/^I enter postcode field "(.*)" as "(.*)"$/) do |field, value|
	fill_in(field, :with => value)
end

Then(/^I click on Add Button$/) do
	page.find(:css, '.btn.btn-danger').click
end

Then(/^I click logout$/) do 
   visit '/logout'
end