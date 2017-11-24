class DeliveryDetails < SitePrism::Section
	element :delivery_date, "input#date.form-control"
	element :select_date, "div.daterangepicker.dropdown-menu.single.opensright.show-calendar > div.calendar.first.single.right > div > table > tbody > tr:nth-child(4) > td:nth-child(5)"
	element :delivery_time, "select[name = 'time']"
	element :error_unavailable, "div#event_add > div > div > form > div.modal-body > div > div > div.form-group.has-error > span > p", visible: false
	element :set, "div#event_add > div > div > form > div.modal-footer > span"

	def select_date_picker(date)
   page.execute_script("$('#date').removeAttr('readonly')")
	 fill_in('date', :with => date) 
	end
end

class AddToCart < SitePrism::Section
	element :add_button, "span#cartUrl"
end

class CatererList < SitePrism::Page
	element :validate_page, :xpath, "/html/body/nav[2]/div/div/ul/li[1]"
	element :select_caterer, "body > div.container > div > div > form > div:nth-child(4)"
	element :error_message, "body > div.container > div > div > div > h3"
end

class StoreMenu < SitePrism::Page
	element :validate_page, :xpath, "/html/body/div[2]/div[1]/div/div/div/h1" 
	element :select_menu, :xpath, "(/html/body/div[4]/div/div[1]/div/div/div/div/ul/li[1]/a)[1]"
	element :add_dish, :xpath, "(//*[@id='mealUrl'])[1]" 
  element :proceed_to_payment, "body > div:nth-child(6) > div > div.menu-wrap > div > div > div.col-sm-5.caterer-menu-order-block > div > a"
	element :validate_page, "body > div.caterer-banner > div.c-info > div > div > div:nth-child(2) > p"
	element :validate_cart, "body > div.menu-wrap > div > div > div.col-sm-5 > div > table > tbody > tr:nth-child(2) > td.text-right > p"
	element :flash_error_mop, "div.alert.alert-danger"
  element :cart_qty_edit, "body > div:nth-child(6) > div > div.menu-wrap > div > div > div.col-sm-5.caterer-menu-order-block > div > div.table-responsive > table > tbody > tr:nth-child(1) > td.form-group.order-menu-qty-cell > input"
	element :cart_error, "body > div.menu-wrap > div > div > div.col-sm-5 > div > table > tbody > tr:nth-child(1) > td.form-group > input > span.help-block > p"
  element :promotion_field, "body > div:nth-child(6) > div > div.menu-wrap > div > div > div.col-sm-5.caterer-menu-order-block > div > div.table-responsive > table > tbody > tr:nth-child(4) > td.text-right > span > input"
  element :apply_promotion, "body > div:nth-child(6) > div > div.menu-wrap > div > div > div.col-sm-5.caterer-menu-order-block > div > div.table-responsive > table > tbody > tr:nth-child(4) > td:nth-child(3) > span"
  element :error_promotion, "body > div:nth-child(6) > div > div.menu-wrap > div > div > div.col-sm-5.caterer-menu-order-block > div > div.table-responsive > table > tbody > tr:nth-child(4) > td.text-right > span > span > p"
  element :successful_promotion, "body > div:nth-child(6) > div > div.menu-wrap > div > div > div.col-sm-5.caterer-menu-order-block > div > div.table-responsive > table > tbody > tr:nth-child(4) > td.text-right > small"
  section :delivery_details, DeliveryDetails, "div.modal-content"
	section :add_to_cart, AddToCart, "div.modal-content"
  
  def manage_cart(data)
  	select_dish
    add_delivery_date_time(data['date'], data['time'])
    add_dish_to_cart
    sleep(2)
    page.execute_script('window.scrollTo(0,500)')
    proceed_to_payment.click
  end

  def manage_cart_caterer_unavailable(data)
		select_dish
    add_delivery_date_time(data['date'], data['time'])
	end

	def manage_cart_exceeding_qty(data)
		select_dish
    add_delivery_date_time(data['date'], data['time'])
    sleep(5)
    add_dish_to_cart
    sleep(2)
    page.execute_script('window.scrollTo(0,500)')
    cart_qty_edit.set(data['invalid_qty'])
	end

  def manage_cart_promotion(data)
    select_dish
    add_delivery_date_time(data['date'], data['time'])
    sleep(5)
    add_dish_to_cart
    sleep(2)
    page.execute_script('window.scrollTo(0,500)')
    promotion_field.set(data['promotion_code'])
    apply_promotion.click
  end

  def manage_cart_checkout(data)
    select_dish
    add_delivery_date_time(data['date'], data['time'])
    sleep(5)
    add_dish_to_cart
    sleep(2)
    page.execute_script('window.scrollTo(0,500)')
    cart_qty_edit.set(data['qty'])
    proceed_to_payment.click
  end

	def select_dish
		select_menu.click
		add_dish.click
	end

	def add_delivery_date_time(date, time)
		delivery_details.delivery_date.click
		delivery_details.select_date_picker(date)
		delivery_details.delivery_time.select(time)
		delivery_details.set.click
	end

	def add_dish_to_cart
		add_to_cart.add_button.click
	end

	def unavilable_caterer(data)
		select_dish
    add_delivery_date_time(data['date'], data['time'])
	end
end