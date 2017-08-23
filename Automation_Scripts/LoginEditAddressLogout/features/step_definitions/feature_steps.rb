
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

Then(/^I should enter new address "(.*)" as "(.*)" and "(.*)" as "(.*)"$/) do |addr_field, addr_value, post_field, post_value|
    within(:css, "li#address") do
        click('Edit')
        window_opened_by do    
            fill_in(addr_field, :with => addr_value)
            fill_in(post_field, :with => post_value)
            click_button('Submit')
            puts "Address Updated!!"
        end
    end
end

#Then(/^I should click on "(.*)" button$/) do |button|
#	click_link(button)
#	puts "Address Updated!!"
#end

Then(/^I should logout from the website$/) do 
   click_link(@@user_name)
   click_link('Logout')
end