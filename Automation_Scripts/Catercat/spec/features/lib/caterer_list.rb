class DeliveryDetails < SitePrism::Section
	element :delivery_date, "input#date.form-control"
	element :select_date, "div.daterangepicker.dropdown-menu.single.opensright.show-calendar > div.calendar.first.single.right > div > table > tbody > tr:nth-child(4) > td:nth-child(5)"
	element :delivery_time, "select[name = 'time']"
	element :set, "div#datetime_add > div > div > form > div.modal-body > small > small > span"

	def select_date_picker(date)
	fill_in('date', :with => date) 
	end
end

class AddToCart < SitePrism::Section
	element :add_button, "span#cartUrl"
end

class CatererList < SitePrism::Page
	element :validate_page, :xpath, "/html/body/nav[2]/div/div/ul/li[1]"
	element :select_caterer, "body > div.container > div:nth-child(2) > div:nth-child(1) > a > div > div > div"
	element :error_message, "body > div.container > div > div > div > h3"
end

class StoreMenu < SitePrism::Page
	element :validate_page, :xpath, "/html/body/div[2]/div[1]/div/div/div/h1"
	element :select_menu, :xpath, "(/html/body/div[3]/div/div/div/ul/li[1]/a)[1]"
	element :add_dish, :xpath, "(//*[@id='mealUrl']/div[1])[1]"
	element :proceed_to_payment, "body > div.menu-wrap > div > div > div.col-sm-5 > div > a"
	section :delivery_details, DeliveryDetails, "div.modal-content"
	section :add_to_cart, AddToCart, "div.modal-content"


	def add_dish_to_cart(data)
		select_menu.click
		add_dish.click
		sleep(2)
		delivery_details.delivery_date.click
		delivery_details.select_date_picker(data['date'])
		delivery_details.delivery_time.select(data['time'])
		delivery_details.set.click
		sleep(5)
		add_dish.click
		add_to_cart.add_button.click
		sleep(2)
		proceed_to_payment.click
	end
end