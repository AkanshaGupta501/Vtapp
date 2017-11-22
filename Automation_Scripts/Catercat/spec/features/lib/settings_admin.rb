class MenuCategory < SitePrism::Page
  element :add_menu, "body > div.container > div.row > div > div.table-wrap.table-responsive > div.tab-content > div > div.pad-div.no-bg > div:nth-child(1) > div > div > button"
  element :add_name, "input[name = 'name']"
  element :submit, "input[value = 'Add Category']"
  element :flash_success, "body > div.container > div.flash-message-position > div.alert.alert-success"
  element :flash_error, "body > div.container > div.flash-message-position > div.alert.alert-danger"
  elements :find_row, "table > tbody > tr"
  element :dont_delete_confirmation, "div#modal-not-delete-menu > div > div > div.modal-body > button"
  element :delete_category, "div#modal-delete-menu > div > div > div.modal-body > form > input.btn.btn-danger"
  def add_new_menu(data)
    add_menu.click
    add_name.set(data)
    submit.click
  end
end

class CuisineCategory < SitePrism::Page
  element :add_cuisine, "body > div.container > div.row > div > div.table-wrap.table-responsive > div.tab-content > div > div.pad-div.no-bg > div:nth-child(1) > div > div > button"
  element :add_name, "input[name = 'name']"
  element :submit, "input[value = 'Add Cuisine']"
  element :flash_success, "body > div.container > div.flash-message-position > div.alert.alert-success"
  element :flash_error, "body > div.container > div.flash-message-position > div.alert.alert-danger"
  elements :find_row, "table > tbody > tr"
  element :dont_delete_confirmation, "#modal-not-delete-cuisine > div > div > div.modal-body > button"
  element :delete_category, "div#modal-delete-cuisine > div > div > div.modal-body > form > input.btn.btn-danger"

  def add_new_cuisine(data)
    add_cuisine.click
    add_name.set(data)
    submit.click
  end
end

class Promotion < SitePrism::Page
  element :add_promo, "body > div.container > div.row > div > div.table-wrap.table-responsive > div.tab-content > div > div.pad-div.no-bg > div:nth-child(1) > div > div > button"
  element :promo_name, "input[name = 'label']"
  element :promo_code, "input[name = 'code']"
  element :percentage, "input[name = 'value']"
  element :start_date, "input[name = 'startdate']"
  element :end_date, "input[name = 'enddate']"
  element :submit, "input[value = 'Create Promo']"
  element :update, "input[value = 'Update']"
  elements :find_row, "table > tbody > tr"
  element :delete_button, "div#modal-delete > div > div > div.modal-body > form > input.btn.btn-danger"
  element :flash_success, "body > div.container > div.flash-message-position > div.alert.alert-success"
  element :flash_error, "body > div.container > div.flash-message-position > div.alert.alert-danger"

  def add_new_promo(data)
    add_promo.click
    promo_name.set(data['promo_name'])
    promo_code.set(data['promo_code'])
    percentage.set(data['percentage'])
    enter_promo_date(data['start_date'], data['end_date'])
    submit.click
  end

  def edit_promo_date(data)
    enter_promo_date(data['invalid_start_date'], data['invalid_end_date'])
    update.click
  end

  def edit_promo_value(data)
    percentage.set(data['percentage'])
    update.click
  end

  def enter_promo_date(startdate, enddate)
    page.execute_script("$('input[name = startdate]').removeAttr('readonly')")
    start_date.set(startdate)
    end_date.click
    page.execute_script("$('input[name = enddate]').removeAttr('readonly')")
    end_date.set(enddate)
  end
end
