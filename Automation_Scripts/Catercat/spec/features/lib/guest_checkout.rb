class DeliveryDetails < SitePrism::Section
	element :delivery_date, "input#date.form-control"
	element :select_date, "body > div.daterangepicker.dropdown-menu.single.opensright.show-calendar > div.calendar.first.single.right > div > table > tbody > tr:nth-child(4) > td:nth-child(3)"
	element :delivery_time, "select[name = 'time']"
	element :set, "div#datetime_add > div > div > form > div.modal-body > small > small > span"
end

class AddToCart < SitePrism::Section
	element :add_button, "span#cartUrl"
end


class GuestCheckout < SitePrism::Page
	element :search_bar, "input[name = 'place']"
	element :find_caterer_button, "input[type = 'submit']"
	element :select_caterer, "body > div.container > div:nth-child(2) > div:nth-child(1) > a > div > div > div"
	element :add_dish, "div#mealUrl > div:nth-child(2) > div > span"
	element :proceed_to_payment, "body > div.menu-wrap > div > div > div.col-sm-5 > div > a"
	element :firstname, "input[name = 'firstname']"
	element :lastname, "input[name = 'lastname']"
	element :email, "input[name = 'email']"
	element :mobile, "input[name = 'mobile']"
	element :address, "input[name = 'address']"
	element :postcode, "input[name = 'postcode']"
	element :suburb, "select[name = 'city']"
	element :checkbox, "input[name = 'sameAsDelivery']"
	element :button_continue, "input[type = 'submit']"
	element :select_eft, "label[data-target = '#eft-details']"
	element :payment_done, "div#eft-details > div:nth-child(6) > div.col-sm-12.text-center > a"
	section :delivery_details, DeliveryDetails, "div.modal-content"
	section :add_to_cart, AddToCart, "div.modal-content"

# 	def fill_autocomplete(field, options = {})
#   fill_in(field, with: options[:with])
#   page.execute_script %Q{ $('##{field}').trigger('focus') }
#   page.execute_script %Q{ $('##{field}').trigger('keydown') }
#   selector = %Q{ul.ui-autocomplete li.ui-menu-item a:contains("#{options[:with]}")}
#   # page.should has_selector?('ul.ui-autocomplete li.ui-menu-item a')
#   page.execute_script %Q{ $('#{selector}').trigger('mouseenter').click() }
# end

 def fill_google_autocomplete(id, text)
    sleep 1
    element = find(id)
    if element
      element.set text
      sleep 1
      element.native.send_keys(:arrow_down)
      element.native.send_keys(:return)
    end
    sleep 1
  end

	def fill_checkout_details(data)
		fill_google_autocomplete('#place', data['suburb'])
		find_caterer_button.click
		select_caterer.click
		first(add_dish).click
		# click_link(add_dish, match: :first)
		sleep(2)
		delivery_details.delivery_date.click
		delivery_details.select_date.click
		delivery_details.delivery_time.select(data['time'])
		delivery_details.set.click
		sleep(2)
		add_dish.click
		add_to_cart.add_button.click
		sleep(2)
		proceed_to_payment.click
		sleep(3)
		firstname.set(data['firstname'])
		lastname.set(data['lastname'])
		email.set(data['email'])
		mobile.set(data['mobile'])
		page.execute_script('window.scrollTo(0,500)')
		address.set(data['address'])
		postcode.set(data['postcode'])
		suburb.select(data['delivery_suburb'])
		checkbox.click
		page.execute_script('window.scrollTo(0,500)')
		button_continue.click
		sleep(5)
		page.execute_script('window.scrollTo(0,100)')
		select_eft.click
		page.execute_script('window.scrollTo(0,100)')
		payment_done.click
	end
end