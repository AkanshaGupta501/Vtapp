class NewAddress < SitePrism::Section
  element :address_field, "textarea[name = 'address']"
  element :postcode, "input[name = 'postcode']"
  element :suburb, "input[name = 'suburb']"
  element :province, "input[name = 'province']"
  element :add_address, "input[type = 'submit']"

  def add_new_address(data)
    address_field.set(data['address'])
    postcode.set(data['postcode'])
    suburb.set(data['delivery_suburb'])
    province.set(data['delivery_suburb'])
    add_address.click
  end
end

class LoginUserCheckoutForm < SitePrism::Page
  element :select_delivery_addr, "div#userOrderAddresses > div:nth-child(1) > h4 > a > small"
  element :add_new_address, "div#listDeliveryAddressesModal > div > div > div.modal-body > form > a"
  element :continue_to_next, "body > div.menu-wrap.white-bg > div > div:nth-child(2) > div > a"
  section :new_address, NewAddress, "div.modal-content"

  def manage_delivery_details
    select_delivery_addr.click
    add_new_address.click
    new_address.add_new_address(data_for('login_user_checkout/correct_details'))
    sleep(2)
    page.execute_script('window.scrollTo(0,50)')
    continue_to_next.click
  end
end