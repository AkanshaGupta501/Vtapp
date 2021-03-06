describe "Guest Checkouts the order" do
  before(:each) do
	@user = Home.new
	@user.load
  end

  scenario "User does not fill suburb" do 
	  @location = FindLocation.new
	  @location.fill_google_autocomplete(data_for('guest_checkout/no_suburb')['suburb'])
    expect(@location.error_message.text).to eq "Please enter the location of your event"
  end

  scenario "Caterer does not exist in selected suburb" do
  	@location = FindLocation.new
  	@location.fill_google_autocomplete(data_for('guest_checkout/no_caterer_in_suburb')['suburb'])
  	@caterer_list = CatererList.new
  	expect(@caterer_list.error_message.text).to eq "No Results Found"
  end

  scenario "Minimum order value is not fulfilled" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/minimum_order_check')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart(data_for('guest_checkout/minimum_order_check'))
    expect(@store_menu.flash_error_mop.text).to eq "Error! Minimum order value is not enough to proceed."
  end

  scenario "Caterer is not available on selected date and time" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/caterer_unavailable')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_caterer_unavailable(data_for('guest_checkout/caterer_unavailable'))
    expect(@store_menu.delivery_details.error_unavailable.text).to eq "Caterer is not available at the selected date and time"
  end

  scenario "User enters meals to cart exceeding the maximum count of meal" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/cart_exceeding_qty')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_exceeding_qty(data_for('guest_checkout/cart_exceeding_qty'))
    expect(@store_menu.has_cart_error?)
  end

  scenario "User enters invalid or non existing promotion code" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/invalid_promotion')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_promotion(data_for('guest_checkout/invalid_promotion'))
    expect(@store_menu.error_promotion.text).to eq "Not available"
  end

  scenario "User enters valid promotion code" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/valid_promotion')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_promotion(data_for('guest_checkout/valid_promotion'))
    expect(@store_menu).to have_successful_promotion
  end

  scenario "User enters wrong checkout details like invalid email" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/invalid_email')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_checkout(data_for('guest_checkout/invalid_email'))
    @guest_checkout = GuestCheckoutForm.new
    @guest_checkout.fill_in_guest_details(data_for('guest_checkout/invalid_email'))
    expect(@guest_checkout.flash_error.text).to eq "Error! Cannot Proceed to Payment, please fill mandatory(*) fields"
  end

  scenario "Guest user IPAY payment is cancelled" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/correct_details')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_checkout(data_for('guest_checkout/correct_details'))
    @guest_form = GuestCheckoutForm.new
    @guest_form.fill_in_guest_details(data_for('guest_checkout/correct_details'))
    @eft = PaymentEft.new
    @eft.choose_eft
    sleep(2)
    @eft.cancelled_payment.click
    expect(@eft.flash_error.text).to eq "Error! Payment could not be completed"
  end

  scenario "Guest user IPAY payment is in pending state" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/correct_details')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_checkout(data_for('guest_checkout/correct_details'))
    @guest_form = GuestCheckoutForm.new
    @guest_form.fill_in_guest_details(data_for('guest_checkout/correct_details'))
    @eft = PaymentEft.new
    @eft.choose_eft
    sleep(3)
    @eft.pending_payment.click
    expect(@eft.flash_error.text).to eq "Error! Payment for this order has already been initiated"
  end

  scenario "Guest user makes a successful IPAY payment" do 
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/correct_details')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_checkout(data_for('guest_checkout/correct_details'))
    @guest_form = GuestCheckoutForm.new
    @guest_form.fill_in_guest_details(data_for('guest_checkout/correct_details'))
    @eft = PaymentEft.new
    @eft.choose_eft
    sleep(3)
    @eft.successful_payment.click
    @order = OrderTrack.new
    expect(@order.order_success.text).to eq "We have received your order"
  end

  # scenario "Guest user PayFast payment is cancelled" do
  #   @location = FindLocation.new
  #   @location.fill_google_autocomplete(data_for('guest_checkout/correct_details')['suburb'])
  #   @caterer_list = CatererList.new
  #   @caterer_list.select_caterer.click
  #   @store_menu = StoreMenu.new
  #   @store_menu.manage_cart_checkout(data_for('guest_checkout/correct_details'))
  #   @guest_form = GuestCheckoutForm.new
  #   @guest_form.fill_in_guest_details(data_for('guest_checkout/correct_details'))
  #   @ext = PaymentExt.new
  #   @ext.choose_ext
  #   sleep(3)
  #   # @ext.cancelled_payment.click
  #   click_link('Cancel')
  #   sleep(10)
  #   expect(@ext.flash_error.text).to eq "Error! Payment for this order has already been initiated"
  # end

  # scenario "Guest user PayFast payment is successful" do
  #   @location = FindLocation.new
  #   @location.fill_google_autocomplete(data_for('guest_checkout/correct_details')['suburb'])
  #   @caterer_list = CatererList.new
  #   @caterer_list.select_caterer.click
  #   @store_menu = StoreMenu.new
  #   @store_menu.manage_cart_checkout(data_for('guest_checkout/correct_details'))
  #   @guest_form = GuestCheckoutForm.new
  #   @guest_form.fill_in_guest_details(data_for('guest_checkout/correct_details'))
  #   @ext = PaymentExt.new
  #   @ext.choose_ext
  #   sleep(3)
  #   @ext.successful_payment.click
  #   sleep(10)
  #   @order = OrderTrack.new
  #   expect(@order.order_success.text).to eq "We have received your order"
  # end

end