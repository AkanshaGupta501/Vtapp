class AddMeal < SitePrism::Section
  element :meal_name, "input[name = 'name']"
  element :meal_summary, "input[name = 'summary']"
  element :meal_description, "textarea[name = 'description']"
  element :price, "input[name = 'price']"
  element :min_qty, "input[name = 'min_quantity']"
  element :max_qty, "input[name = 'max_quantity']"
  element :serves, "input[name = 'serves']"
  elements :cuisine, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div.container > div > div.col-sm-7 > div:nth-child(2) > div > div > label"
  elements :category, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div.container > div > div.col-sm-7 > div:nth-child(3) > div > div > label"
  elements :allergens,"body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div.container > div > div.col-sm-7 > div:nth-child(4) > div > div > label"
  elements :meal_type, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div.container > div > div.col-sm-7 > div:nth-child(5) > div > div > label"
  elements :availability_days, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div.container > div > div.col-sm-5 > div:nth-child(2) > div > div > label"
  element :create_meal, "input[value = 'Create']"

  def add_new_meal(data)
    puts data
    meal_name.set(data['meal_name'])
    meal_summary.set(data['summary'])
    meal_description.set(data['description'])
    price.set(data['price'])
    min_qty.set(data['min_qty'])
    max_qty.set(data['min_qty'].to_i + 10)
    serves.set(data['serves'])
    cuisine.each do |cuisine_id|
      cuisine_id.click if data['cuisine'] == cuisine_id.text
    end
    category.each do |category_id|
      category_id.click if data['category'] == category_id.text
    end
    allergens.each do |allergen|
      allergen.click if data['allergens'].include?(allergen.text)
    end
    meal_type.each do |type|
      type.click if data['meal_type'].include?(type.text)
    end
    availability_days.each do |day|
      day.click if data['availability_days'] == day.text
    end
    create_meal.click
  end
end





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
  element :status, "body > div.container > div.row > div.col-sm-12 > div.table-wrap.table-responsive > table > tbody > tr:nth-child(1) > td:nth-child(6) > div > a.btn.btn-danger.btn-sm"

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
  element :go_to_bank, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > ul > li:nth-child(5) > a"
  element :go_to_meals, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > ul > li:nth-child(6) > a"
  element :order_acceptance, "select[name = 'min_lead_time']"
  elements :availability_days, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div > div > div.col-sm-3 > form > div:nth-child(4) > div > label"
  elements :availability_time, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div > div > div.col-sm-3 > form > div:nth-child(5) > div.checkbox > label"
  element :add_province, "select[name = 'province_id']"
  element :add_suburb, "select[name = 'suburb_id']"
  element :add_province_suburb, "input[value = 'Add']"
  element :suburb_section, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div > div > div > div > div.col-sm-8.col-sm-offset-1 > div:nth-child(2) > table"
  element :account_name, "input[name = 'bank_account_name']"
  element :bank_id, "select[name = 'bank_id']"
  element :branch_code, "input[name = 'bank_branch_code']"
  element :account_number, "input[name = 'bank_account_number']"
  element :account_type, "select[name = 'bank_account_type']"
  element :add_meal_link, "div#meals > div > div:nth-child(1) > div.col-sm-6.text-right > a"
  section :add_meal, AddMeal, "body > div.container > div.container > div > div > div.table-wrap.table-responsive > div > div.tab-content"
  elements :verify_added_meal, "div#meals > div > div:nth-child(2) > div > div > table > tbody > tr > td:nth-child(2)"
  element :caterer_status, "div#pending > table > tbody > tr:nth-child(3) > td:nth-child(5) > div > a.btn.btn-danger"


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
    order_acceptance.select(data['order_acceptance_time'])
    availability_days.each do |day|
      day.click if data['availability_days'] == day.text
    end
    availability_time.each do|input| 
      input.click if data['availability_time'].include?(input.text) && (input.find(:css,'input[type="checkbox"]').checked? == false)
      input.click if !data['availability_time'].include?(input.text) && (input.find(:css,'input[type="checkbox"]').checked? == true)
    end
    update.click 
  end

  def manage_province(data)
    data['number_times'].times do
      suburb_name = data_for('admin_manage_caterer/suburbs_data')['suburb']
      if suburb_section.text.include? suburb_name
        puts "The given suburb exists in caterer's list"
      else
        add_province.select(data['province'])
        add_suburb.select(suburb_name)
        add_province_suburb.click
      end
    end
    update.click 
  end

  def bank_details(data)
    account_name.set(data['account_name'])
    bank_id.select(data['bank_id'])
    branch_code.set(data['branch_code'])
    account_number.set(data['account_number'])
    account_type.select(data['account_type'])
    update.click
  end
  
  def admin_add_meal(data)
    add_meal_link.click
    add_meal.add_new_meal(data)
  end
end


