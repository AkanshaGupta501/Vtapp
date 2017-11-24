class GuestCheckoutForm < SitePrism::Page
  element :firstname, "input[name = 'firstname']"
	element :lastname, "input[name = 'lastname']"
	element :email, "input[name = 'email']"
	element :mobile, "input[name = 'mobile']"
	element :address, "textarea[name = 'address']"
	element :postcode, "input[name = 'postcode']"
	element :suburb, "input[name = 'suburb']"
	element :province, "input[name = 'province']"
	element :checkbox, "input[name = 'sameAsDelivery']"
	element :button_continue, "input[type = 'submit']"
	element :flash_error, "body > div.flash-message-position > div.alert.alert-danger"


  def fill_in_guest_details(data)
    firstname.set(data['firstname'])
		lastname.set(data['lastname'])
		email.set(data['email'])
		mobile.set(data['mobile'])
		page.execute_script('window.scrollTo(0,500)')
		address.set(data['address'])
		postcode.set(data['postcode'])
		suburb.set(data['delivery_suburb'])
		province.set(data['delivery_suburb'])
		page.execute_script('window.scrollTo(0,700)')
		checkbox.click
		page.execute_script('window.scrollTo(0,1000)')
		button_continue.click
  end
end