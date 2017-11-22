describe  "Admin manages different settings of Admin Panel" do
  before(:each) do    
    @admin_home = AdminHome.new
    @admin_home.load
    @admin_home.fill_login_details(data_for("admin_login/valid_details"))
    @admin_home.admin_name.click
    @admin_home.goto_admin_settings
  end

  # scenario "Admin adds new-non existing menu category" do
  #   @menu = MenuCategory.new
  #   @@menu_category_name = data_for("admin_settings/add_menu_category")['name']
  #   @menu.add_new_menu(@@menu_category_name)
  #   expect(@menu.flash_success.text).to eq "Success! Menu category created."
  # end

  # scenario "Admin adds new existing menu category" do
  #   @menu = MenuCategory.new
  #   @menu.add_new_menu(data_for("admin_settings/add_existing_menu_category")['name'])
  #   expect(@menu.flash_error.text).to eq "Error! Form could not be submitted."
  # end

  # scenario  "Admin removes a menu category that has linked data" do
  #   @menu = MenuCategory.new
  #   @menu_item = data_for("admin_settings/add_existing_menu_category")['name']
  #   @menu.find_row.each do |value|
  #     if value.find("td:nth-child(1)").text == @menu_item
  #       value.find("td:nth-child(2) > div > a.btn.btn-danger").click
  #       @menu.dont_delete_confirmation.click
  #       expect(value.find("td:nth-child(1)").text).to eq @menu_item
  #       break
  #     else
  #       page.execute_script('window.scrollTo(0,500)')
  #     end
  #   end
  # end

  # scenario "Admin removes a menu category that has no linked data" do
  #   @menu = MenuCategory.new
  #   @menu.find_row.each do |value|
  #     if value.find("td:nth-child(1)").text == @@menu_category_name
  #       value.find("td:nth-child(2) > div > a.btn.btn-danger").click
  #       @menu.delete_category.click
  #       expect(@menu.flash_success.text).to eq "Success! Category deleted."
  #       break
  #     else
  #       page.execute_script('window.scrollTo(0,300)')
  #     end
  #   end
  # end

  # scenario "Admin adds new non-existing cuisine" do
  #   @admin_home.goto_cuisine.click
  #   @cuisine = CuisineCategory.new
  #   @@cuisine_name = data_for("admin_settings/add_cuisine")['name']
  #   @cuisine.add_new_cuisine(@@cuisine_name)
  #   expect(@cuisine.flash_success.text).to eq "Success! Cuisine created"
  # end

  # scenario "Admin adds existing cuisine" do
  #   @admin_home.goto_cuisine.click
  #   @cuisine = CuisineCategory.new
  #   @cuisine.add_new_cuisine(data_for("admin_settings/add_existing_cuisine")['name'])
  #   expect(@cuisine.flash_error.text).to eq "Error! Form could not be submitted."
  # end

  # scenario "Admin deletes a cuisine with linked meals" do
  #   @admin_home.goto_cuisine.click
  #   @cuisine = CuisineCategory.new
  #   @name_cuisine = data_for("admin_settings/add_existing_cuisine")['name']
  #   @cuisine.find_row.each do |value|
  #     if value.find("td:nth-child(1)").text == @name_cuisine
  #       value.find("td:nth-child(2) > div > a.btn.btn-danger").click
  #       @cuisine.dont_delete_confirmation.click
  #       expect(value.find("td:nth-child(1)").text).to eq @name_cuisine
  #       break
  #     else
  #       page.execute_script('window.scrollTo(0,500)')
  #     end
  #   end
  # end

  # scenario "Admin deletes a cuisine with no meals linked to it" do
  #   @admin_home.goto_cuisine.click
  #   @cuisine = CuisineCategory.new
  #   @cuisine.find_row.each do |value|
  #     if value.find("td:nth-child(1)").text == @@cuisine_name
  #       value.find("td:nth-child(2) > div > a.btn.btn-danger").click
  #       @cuisine.delete_category.click
  #       expect(@cuisine.flash_success.text).to eq "Success! Cuisine deleted"
  #       break
  #     else
  #       page.execute_script('window.scrollTo(0,300)')
  #     end
  #   end
  # end

  # scenario "Admin adds new promocode with correct values" do
  #   @admin_home.goto_promotion.click
  #   @promotion = Promotion.new
  #   @@promo_code_test = data_for("admin_settings/add_correct_promo")
  #   @promotion.add_new_promo(@@promo_code_test)
  #   expect(@promotion.flash_success.text).to eq "Success! Promotion created"
  # end

  # scenario "Admin adds new promocode with end date lesser than start date" do
  #   @admin_home.goto_promotion.click
  #   @promotion = Promotion.new
  #   @promotion.add_new_promo(data_for("admin_settings/add_incorrect_promo_date"))
  #   expect(@promotion.flash_error.text).to eq "Error! Form could not be submitted."
  # end

  # scenario "Admin adds existing promo code" do
  #   @admin_home.goto_promotion.click
  #   @promotion = Promotion.new
  #   @promotion.add_new_promo(data_for("admin_settings/add_existing_promo_code"))
  #   expect(@promotion.flash_error.text).to eq "Error! Form could not be submitted."
  # end

  # scenario "Admin enters invalid percentage to the promotional value" do
  #   @admin_home.goto_promotion.click
  #   @promotion = Promotion.new
  #   @promotion.add_new_promo(data_for("admin_settings/add_invalid_promotion_value"))
  #   expect(@promotion.flash_error.text).to eq "Error! Form could not be submitted." 
  # end

  # scenario "Admin deletes a promocode" do
  #   @admin_home.goto_promotion.click
  #   @promotion = Promotion.new
  #   @promotion.find_row.each do |value|
  #     if value.find("td:nth-child(2)").text == @@promo_code_test['promo_code']
  #       value.find("td:nth-child(6) > div > a.btn.btn-danger").click
  #       @promotion.delete_button.click
  #       expect(@promotion.flash_success.text).to eq "Success! Promotion deleted"
  #       break
  #     else
  #       page.execute_script('window.scrollTo(0,300)')
  #     end
  #   end
  # end

  scenario "Admin edits existing promocode and enters invalid dates" do
    @admin_home.goto_promotion.click
    @promotion = Promotion.new
    @promotion.find_row.each do |value|
      if value.find("td:nth-child(2)").text == data_for('admin_settings/edit_promocode_date')['promo_code']
        value.find("td:nth-child(6) > div > a.btn.btn-default").click
        @promotion.edit_promo_date(data_for('admin_settings/edit_promocode_date'))
        expect(@promotion.flash_error.text).to eq "Error! Form could not be submitted."
        break
      else
        page.execute_script('window.scrollTo(0,300)')
      end
    end
  end

  scenario "Admin edits existing promocode and enters invalid promo value" do
    @admin_home.goto_promotion.click
    @promotion = Promotion.new
    @promotion.find_row.each do |value|
      if value.find("td:nth-child(2)").text == data_for('admin_settings/edit_promo_value')['promo_code']
        value.find("td:nth-child(6) > div > a.btn.btn-default").click
        @promotion.edit_promo_value(data_for('admin_settings/edit_promo_value'))
        expect(@promotion.flash_error.text).to eq "Error! Form could not be submitted."
        break
      else
        page.execute_script('window.scrollTo(0,300)')
      end
    end
  end
end