class LoginModal < SitePrism::Section
  element :user_email_id, "input[name = 'email']"
  element :user_password, "input[name= 'password']"
  element :remember_me, "input[name = 'remember_me']"
  element :login_button, "input[type = 'submit']"
  element :error_message, "span.help-block > p"

  def fill_login_details(data)
    user_email_id.set(data['email'])
    user_password.set(data['password'])
    login_button.click
  end
end

class SignUpModal < SitePrism::Section
  element :user_first_name, "input[name = 'firstname']"
  element :user_last_name, "input[name = 'lastname']"
  element :user_email_id, "input[name = 'email']"
  element :user_phone_number, "input[name = 'mobile']"
  element :user_new_password, "input[name = 'password']"
  element :user_confirm_password,"input[name = 'password_confirmation']"
  element :signup_button, "input[type = 'submit']"
  element :error_message, "span.help-block > p"

  def fill_signup_details(data)
    user_first_name.set(data['firstname'])
    user_last_name.set(data['lastname'])
    user_email_id.set(data['email'])
    user_phone_number.set(data['phone'])
    user_new_password.set(data['new_password'])
    user_confirm_password.set(data['confirm_password'])
    signup_button.click
  end
end

class AddNewAddress < SitePrism::Section
  element :address_field, "textarea[name= 'address']"
  element :postcode, "input[name='postcode']"
  element :suburb, "select[name= 'city']"
  element :submit_addr, "input[type='submit']"

  def fill_new_address(data)
    address_field.set(data['address'])
    postcode.set(data['postcode'])
    suburb.find(data['suburb']).click
    submit_addr.click
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

#class LoginSignup < SitePrism::Section
#  section :login, LoginModal, 'div.modal-content'
#  section :signup, SignUpModal, 'div.modal-content'
#end

class Home < SitePrism::Page
  set_url '/'
  element :login_modal_window, "a[data-target = '#loginModal']"
  element :signup_modal_window, "a[data-target = '#signupModal']"
  element :user_name, "li.dropdown.a.dropdown-toggle"
  section :loginmodal, LoginModal, 'div.modal-content'
  section :signupmodal, SignUpModal, 'div#signupModal'
end

class UserPanel < SitePrism::Page
  element :user_name, "a.dropdown-toggle"
end

class UserProfile < SitePrism::Page
  section :change_password, ChangePassword, "div.form-box.password"
  #section :add_address_modal, AddNewAddress, "html"
  element :address_field, "textarea[name= 'address']"
  element :postcode, "input[name='postcode']"
  element :suburb, "select[name= 'city']"
  element :submit_addr, "input[type='submit']"

  def fill_new_address(data)
    address_field.set(data['address'])
    postcode.set(data['postcode'])
    suburb.find(data['suburb']).click
    submit_addr.click
  end
end