describe "Guest Checkouts the order" do
  before(:each) do
	@user = Home.new
	@user.load
  end

  scenario "User does not fill suburb" do 
	  @location = FindLocation.new
	  @location.fill_google_autocomplete(data_for('guest_checkout/no_suburb')['suburb'])
    expect(@location.error_message.text).to eq "Suburb is required"
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
    expect(@store_menu.flash_error_mop.text).to eq "Error! Can not proceed due to the following errors"
  end

  scenario "Caterer is not available on selected date and time" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/caterer_unavailable')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_caterer_unavailable(data_for('guest_checkout/caterer_unavailable'))
    expect(@store_menu.delivery_details.error_unavailable.text).to eq "Selected caterer not available at that date & time"
  end

  scenario "User enters meals to cart exceeding the maximum count" do
    @location = FindLocation.new
    @location.fill_google_autocomplete(data_for('guest_checkout/cart_exceeding_qty')['suburb'])
    @caterer_list = CatererList.new
    @caterer_list.select_caterer.click
    @store_menu = StoreMenu.new
    @store_menu.manage_cart_exceeding_qty(data_for('guest_checkout/cart_exceeding_qty'))
    page.find("body").click
    expect(@store_menu.has_cart_error?)
  end

  # scenario "Fill in correct details for checkout" do 
	 #  @location = FindLocation.new
	 #  @location.fill_google_autocomplete(data_for('guest_checkout/correct_details')['suburb'])
	 #  @caterer_list = CatererList.new
	 #  @caterer_list.select_caterer.click
	 #  @store_menu = StoreMenu.new
  #   @store_menu.manage_cart(data_for('guest_checkout/correct_details'))
	 #  @guest_form = GuestCheckoutForm.new
	 #  @guest_form.fill_in_guest_details(data_for('guest_checkout/correct_details'))
	 #  @eft = PaymentEft.new
  #   @eft.choose_eft
  #   @order = OrderTrack.new
  #   expect(@order.order_success.text).to eq "We have received your order"
  # end
end