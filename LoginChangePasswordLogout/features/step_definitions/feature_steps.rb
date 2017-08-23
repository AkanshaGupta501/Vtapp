
Given(/^I am on CaterCat Main Page$/) do
    visit'/'
    click_link('Login / Signup')
end

When(/^I enter "(.*)" for login with "(.*)"$/) do |field, value|
    fill_in(field,:with => value)
end

Then(/^I enter "(.*)" as password for login "(.*)"$/) do |field, value|
	@@old_password = value
    fill_in(field,:with => value)
end

Then(/^I click "(.*)" button$/) do |button|
    click_button(button)
end

Then(/^I should see User Name$/) do 
    anchor_link = find(:xpath, "//a[@class='dropdown-toggle']") 
    @@user_name = anchor_link.native.text
    puts "Hello, User! #{@@user_name}"

end

Then(/^I should Go to "(.*)" Section$/) do |section|
	click_link(@@user_name)
	click_link(section)
end

Then(/^I should add old password$/) do
	fill_in('old_password', :with => @@old_password)
end

Then(/^I should add new password as "(.*)"$/) do |new_password|
	fill_in('password',:with => new_password)
end

Then(/^I should add confirm password as "(.*)"$/) do |confirm_password|
	fill_in('password_confirmation',:with => confirm_password)
end

Then(/^I should click on Save button$/) do
	page.find(:css, '.btn.btn-success:nth-child(6)').click
	puts "Password Updated!!"
end

Then(/^I should logout from the website$/) do 
   click_link(@@user_name)
   click_link('Logout')
end