class LoginModal < SitePrism::Section
  element :user_email_id, "input[name = 'email']"
  element :user_password, "input[name= 'password']"
  element :remember_me, "input[name = 'remember_me']"
  element :login_button, "input[value = 'LOG IN']"
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
  element :signup_button, "input[value = 'SIGN UP']"
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

#class LoginSignup < SitePrism::Section
#  section :login, LoginModal, 'div.modal-content'
#  section :signup, SignUpModal, 'div.modal-content'
#end

class Home < SitePrism::Page
  set_url '/'
  element :login_modal_window, "a[data-target = '#loginModal']"
  element :signup_form, "a[data-target = '#signupModal']"
  element :user_name, "li.dropdown.a.dropdown-toggle"
  section :loginmodal, LoginModal, 'div.modal-content'
  section :signupmodal, SignUpModal, 'div#signupModal'

  def load_signup_form
    login_modal_window.click
    signup_form.click
  end

  def get_user_name(data)
    data['firstname'] + " " + data['lastname']
  end

  def make_user_login
    login_modal_window.click
    loginmodal.fill_login_details(data_for("login/valid_email_password"))
  end
end

class UserPanel < SitePrism::Page
  element :user_name, "a.dropdown-toggle"

  def go_to_profile
    user_name.click
    click_link('My Profile')
  end
end
