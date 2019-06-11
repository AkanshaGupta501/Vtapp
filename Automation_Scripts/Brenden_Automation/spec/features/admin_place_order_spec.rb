describe "Admin Manages Users" do 
  
  before(:each) do
    @admin_home = AdminHome.new
    @admin_home.load
    @admin_home.fill_login_details(data_for("admin_login/valid_details"))
    expect(@admin_home.admin_name.text).to eq "CaterCat Admin"
    @user = AddNewUser.new
    @user.go_to_users.click
  end
  
  scenario "Admin places an order for guest user with correct details" do
    @admin = AdminPlaceOrder.new
    @user_details = data_for("guest_checkout/correct_details")
    new_window = window_opened_by{ @admin.guest_checkout.click }
    within_window new_window do
      sleep(5)
      @location = FindLocation.new
      @location.fill_google_autocomplete(@user_details['suburb'])
      @caterer_list = CatererList.new
      @caterer_list.select_caterer.click
      @store_menu = StoreMenu.new
      @store_menu.manage_cart_checkout(@user_details)
      @guest_form = GuestCheckoutForm.new
      @guest_form.fill_in_guest_details(@user_details)
      @admin.pay_button.click
      @order = OrderTrack.new
      expect(@order.order_success.text).to eq "We have received your order"
    end
  end

  scenario "Admin places an order for registered user with correct details" do
    @admin = AdminPlaceOrder.new
    @admin.select_user(data_for('login_user_checkout/user_name'))
    new_window = window_opened_by{ @admin.order_for_user.click }
    within_window new_window do
      sleep(5)
      @location = FindLocation.new
      @location.fill_google_autocomplete(data_for('login_user_checkout/correct_details')['suburb'])
      @caterer_list = CatererList.new
      @caterer_list.select_caterer.click
      @store_menu = StoreMenu.new
      @store_menu.manage_cart_checkout(data_for('login_user_checkout/correct_details'))
      @login_user_checkout = LoginUserCheckoutForm.new
      @login_user_checkout.continue_to_next.click
      @admin.pay_button.click
      @order = OrderTrack.new
      expect(@order.order_success.text).to eq "We have received your order"
    end
  end
end