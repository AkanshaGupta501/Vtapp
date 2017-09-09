class AdminHome < SitePrism::Page
  set_url '/admin/login'
  element :email_id, "input[name = 'email']"
  element :password, "input[name = 'password']"
  element :login_button, "input[type = 'submit']"
  element :error_message, "div.account-box > span > ul > li"
  element :admin_name, "a.dropdown-toggle"

  def fill_login_details(data)
    email_id.set(data['email_id'])
    password.set(data['password'])
    login_button.click
  end
end