
Given(/^I am on Catercat Main Page$/) do
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

Then(/^I click on "(.*)" button for login to catercat$/) do |button|
    click_button(button)
end

Then(/^I should see User Name$/) do 
    anchor_link = find(:xpath, "//a[@class='dropdown-toggle']") 
    @@user_name = anchor_link.native.text
    puts "Hello, User! #{@@user_name}"
    #click_link(@@user_name)

end

Then(/^I Go to "(.*)" Section and "(.*)"$/) do |user_profile, new_address|
  click_link(@@user_name)
  click_link(user_profile)
  click_on(new_address)
end

Then(/^I should enter new address "(.*)" as "(.*)" and "(.*)" as "(.*)" and select "(.*)" as "(.*)"$/) do |addr_field, addr_value, post_field, post_value, city_field, city_value|   
  fill_in(addr_field, :with => addr_value)
  fill_in(post_field, :with => post_value)
  select(city_value, :from => city_field).native.send_key(:enter)      
  puts "Address Updated!!"
end

Then(/^I go to "(.*)" link$/) do |new_card|
  click_on(new_card)
end

Then(/^I should enter "(.*)" as "(.*)" my "(.*)" as "(.*)" select "(.*)" as "(.*)" and select "(.*)" as "(.*)" and save the details$/) do |card_name, name_value, card_number, number_value, card_expiry_month, expiry_month_value, card_expiry_year, expiry_year_value|
  fill_in(card_name, :with => name_value)
  fill_in(card_number, :with => number_value)
  select(expiry_month_value, :from => card_expiry_month)
  select(expiry_year_value, :from => card_expiry_year).native.send_key(:enter)
end

Then(/^I should display success message$/) do
  puts "Credit Card Number Added Successfully!!"
end