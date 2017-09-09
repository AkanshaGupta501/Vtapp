class GuestCheckoutForm < SitePrism::Page
  element :firstname, "input[name = 'firstname']"
	element :lastname, "input[name = 'lastname']"
	element :email, "input[name = 'email']"
	element :mobile, "input[name = 'mobile']"
	element :address, "input[name = 'address']"
	element :postcode, "input[name = 'postcode']"
	element :suburb, "select[name = 'city']"
	element :checkbox, "input[name = 'sameAsDelivery']"
	element :button_continue, "input[type = 'submit']"


  def fill_in_guest_details(data)
    firstname.set(data['firstname'])
		lastname.set(data['lastname'])
		email.set(data['email'])
		mobile.set(data['mobile'])
		page.execute_script('window.scrollTo(0,500)')
		address.set(data['address'])
		postcode.set(data['postcode'])
		suburb.select(data['delivery_suburb'])
		page.execute_script('window.scrollTo(0,700)')
		checkbox.click
		page.execute_script('window.scrollTo(0,1000)')
		button_continue.click
  end
end