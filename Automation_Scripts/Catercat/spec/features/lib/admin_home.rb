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

class AddNewUser < SitePrism::Page
  element :go_to_users, "body > nav.navbar.sub-navbar > div > div > ul > li:nth-child(1) > a"
  element :add_user_link, "body > div.container > div.row > div.col-sm-12 > div.row > div.col-sm-9 > div > div > div.col-sm-2 > a"
  element :firstname, "input[name = 'firstname']"
  element :lastname, "input[name = 'lastname']"
  element :email_id, "input[name = 'email']"
  element :contact, "input[name = 'mobile']"
  element :address, "textarea[name = 'address']"
  element :suburb, "select[name= 'city']"
  element :postcode, "input[name = 'postcode']"
  element :submit, "input[value = 'Add']"
  element :flash_success, "div.alert.alert-success"
  element :flash_error, "div.alert.alert-danger"

  def fill_user_details(data)
    firstname.set(data['firstname'])
    lastname.set(data['lastname'])
    email_id.set(data['email_id'])
    contact.set(data['contact'])
    address.set(data['address'])
    suburb.select(data['suburb'])
    postcode.set(data['postcode'])
    submit.click
  end
end

class EditUser < SitePrism::Page
  element :go_to_users, "body > nav.navbar.sub-navbar > div > div > ul > li:nth-child(1) > a"
  elements :rows, "body > div.container > div.row > div.col-sm-12 > div.table-wrap.table-responsive > table > tbody > tr"
  element :firstname, "input[name = 'firstname']"
  element :lastname, "input[name = 'lastname']"
  element :email, "input[name = 'email']"
  element :contact, "input[name = 'mobile']"
  element :address, "textarea[name = 'address']"
  element :suburb, "select[name= 'city']"
  element :postcode, "input[name = 'postcode']"
  element :update, "input[value = 'Update']"
  element :flash_success, "div.alert.alert-success > strong"

  def update_user_details(data)
    firstname.set(data['firstname'])
    lastname.set(data['lastname'])
    contact.set(data['contact'])
    address.set(data['address'])
    suburb.select(data['suburb'])
    postcode.set(data['postcode'])
    update.click
  end
end


class AddNewCaterer < SitePrism::Page
  element :go_to_caterer, "body > nav.navbar.sub-navbar > div > div > ul > li:nth-child(2) > a"
  element :add_caterer_link, "body > div.container > div.row > div > div.row > div:nth-child(2) > div > div > div.col-sm-4 > a"
  element :firstname, "input[name = 'firstname']"
  element :lastname, "input[name = 'lastname']"
  element :email_id, "input[name = 'email']"
  element :contact, "input[name = 'mobile']"
  element :add_caterer_button, "input[value = 'Add Caterer']"
  element :flash_caterer_created_success, "div.alert.alert-success"
  element :flash_caterer_created_error, "div.alert.alert-danger"
  element :business_name, "input[name = 'business_name']"
  element :business_address, "textarea[name = 'business_address']"
  element :business_city, "select[name = 'business_city']"
  element :postcode, "input[name = 'business_postcode']"
  element :about_us, "textarea[name = 'business_about']"
  element :update_caterer, "input[value = 'Update']"
  element :flash_caterer_updated_success, "div.alert.alert-success"
  element :flash_caterer_updated_error, "div.alert.alert-danger"

  def create_caterer(data)
    firstname.set(data['firstname'])
    lastname.set(data['lastname'])
    email_id.set(data['email_id'])
    contact.set(data['contact'])
    add_caterer_button.click
  end

  def update_business_details(data)
    business_name.set(data['name'])
    business_address.set(data['address'])
    business_city.select(data['suburb'])
    postcode.set(data['postcode'])
    about_us.set(data['aboutus'])
    update_caterer.click
  end
end

class EditCaterer < SitePrism::Page
  element :go_to_approved, "body > div.container > div.row > div > div.table-wrap.table-responsive > div > ul > li:nth-child(2) > a"
  element :go_to_pending, "body > div.container > div.row > div > div.table-wrap.table-responsive > div > ul > li:nth-child(1) > a"
  element :go_to_declined, "body > div.container > div.row > div > div.table-wrap.table-responsive > div > ul > li:nth-child(3) > a"
  elements :rows, "div#pending > table > tbody > tr"
  element :firstname, "input[name = 'firstname']"
  element :lastname, "input[name = 'lastname']"
  element :email_id, "input[name = 'email']"
  element :contact, "input[name = 'mobile']"
  element :update, "input[value = 'Update']"
  element :go_to_caterer_profile, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > ul > li:nth-child(2) > a"
  element :business_address, "textarea[name = 'business_address']"
  element :business_city, "select[name = 'business_city']"
  element :postcode, "input[name = 'business_postcode']"
  element :about_us, "textarea[name = 'business_about']"
  element :flash_caterer_updated_success, "div.alert.alert-success > strong"
  element :go_to_orders, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > ul > li:nth-child(3) > a"
  element :delivery_fee, "input[name = 'delivery_fee']"
  element :mov, "input[name = 'min_order_val']"
  element :mot, "select[name = 'order_acceptance_time']"
  element :go_to_availability, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > ul > li:nth-child(4) > a"
  element :order_acceptance, "select[name = 'min_lead_time']"
  element :availability_days, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div > div > div.col-sm-3 > form > div:nth-child(4)"
  element :availability_time, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div > div > div.col-sm-3 > form > div:nth-child(5)"
  element :add_province, "select[name = 'province_id']"
  element :add_suburb, "select[name = 'suburb_id']"
  element :add_province_suburb, "input[value = 'Add']"


  def edit_contact_details(data)
    firstname.set(data['name'])
    lastname.set(data['lastname'])
    contact.set(data['contact'])
    update.click
  end

  def edit_business_details(data)
    business_address.set(data['address'])
    business_city.select(data['suburb'])
    postcode.set(data['postcode'])
    about_us.set(data['aboutus'])
    update.click
  end

  def edit_order_details(data)
    delivery_fee.set(data['delivery_fee'])
    mov.set(data['mov'])
    mot.select(data['mot'])
    update.click
  end

  def edit_availability_days(data)
    puts data
    order_acceptance.select(data['order_acceptance_time'])
    # availability_days.check(data['availability_days'])
    data['availability_time'].each{|time| availability_time.find("div.checkbox:nth-child(#{time})").click}
    update.click
    add_province.select(data['province'])
    add_suburb.select(data['suburb'])
    add_province_suburb.click
  end
  
end


