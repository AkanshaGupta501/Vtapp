Given(/^I am on Catercat User Site$/) do
	 visit '/'
	 click_link('Login / Signup')
    click_link('Sign Up Now')
end

When(/^I enter first name "(.*)" as "(.*)"$/) do |field, value|
   @@user_name = value
 	fill_in(field, :with => value)
end

Then(/^I enter last name "(.*)" as "(.*)"$/) do |field, value|
	@@user_name << " " + value
	fill_in(field, :with => value )
end

Then(/^I enter email "(.*)" as "(.*)"$/) do |field, value|
	fill_in(field, :with => value)
end

Then(/^I enter mobile "(.*)" as "(.*)"$/) do |field, value|
	fill_in(field, :with => value)
end

Then(/^I enter password "(.*)" as "(.*)"$/) do |field, value|
	fill_in(field, :with => value)
end

Then(/^I enter confirm password "(.*)" as "(.*)"$/) do |field, value|
	fill_in(field, :with => value)
end

Then(/^I click signup button "(.*)"$/) do |field|
	click_button(field)
end

Then(/^I display message of script completion$/) do
	puts "Hello #{@@user_name}, your account created"
	visit '/user/logout'
	#visit '/'
end
