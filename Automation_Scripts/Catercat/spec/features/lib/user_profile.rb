class AddNewAddress < SitePrism::Section
  element :address_field, "textarea[name= 'address']"
  element :postcode, "input[name='postcode']"
  element :suburb, "select[name= 'city']"
  element :submit_addr, "input[type='submit']"
  element :close_modal, "div#addAddressModal.modal.fade.in > div > div > div.modal-header > button > span"
  element :error_message, "div.form-group.has-error > span.help-block > p"

  def fill_new_address(data)
    address_field.set(data['address'])
    postcode.set(data['postcode'])
    suburb.select(data['suburb'])
    submit_addr.click
  end
end

class EditAddress < SitePrism::Section
  element :delete_button, "a#addressDelete"
  element :address_field, "textarea[name = 'address']"
  element :postcode, "input[name='postcode']"
  element :suburb, "select[name= 'city']"
  element :submit_addr, "input[type='submit']"

  def delete_address
    delete_button.click
  end

  def update_address(data)
    address_field.set(data['address'])
    postcode.set(data['postcode'])
    suburb.select(data['suburb'])
    submit_addr.click
  end
end

class DefaultAddressConfirmation < SitePrism::Section
  element :set_default, "input[type = 'submit']"
  element :cancel, "button[type = 'button']"

  def set_address_default
    set_default.click
  end
end

class ChangePassword < SitePrism::Section
  element :old_password, "input[name = 'old_password']"
  element :new_password, "input[name= 'password']"
  element :confirm_password, "input[name= 'password_confirmation']"
  element :submit, "input[type = 'submit']"

  def enter_new_password(data)
    old_password.set(data['old_password'])
    new_password.set(data['new_password'])
    confirm_password.set(data['confirm_password'])
    submit.click
  end
end

class UserProfile < SitePrism::Page
  element :address_link, "li#address > a"
  element :add_address, "div.form-box.address > h4 > a" 
  element :password_link, "li#password > a"
  element :flash_error, "div.alert.alert-danger"
  element :flash_success, "div.alert.alert-success"
  element :edit_address_link, :xpath, "(//*[@id='address']/div[1]/a)[1]"
  element :set_default_address, :xpath, "(//*[@id='address']/div[2]/p/a)[2]"
  section :add_address_modal, AddNewAddress, "div#addAddressModal > div > div.modal-content"
  section :change_password, ChangePassword, "div.form-box.password"
  section :edit_address_modal, EditAddress, "div#editAddressModal > div > div.modal-content"
  section :default_address_modal ,DefaultAddressConfirmation, "div#defaultAddressConfirmationModal > div > div.modal-content"
end