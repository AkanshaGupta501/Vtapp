describe "Guest Checkouts the order" do
before(:all) do
	@user = Home.new
	@user.load
end

scenario "Fill in correct details for checkout" do 
	@location = FindLocation.new
	@location.fill_google_autocomplete(data_for('guest_checkout/details')['suburb'])
	@caterer_list = CatererList.new
	@caterer_list.select_caterer.click
	@store_menu = StoreMenu.new
	@store_menu.add_dish_to_cart(data_for('guest_checkout/details'))
	@guest_form = GuestCheckoutForm.new
	@guest_form.fill_in_guest_details(data_for('guest_checkout/details'))
	@eft = PaymentEft.new
  @eft.choose_eft
  @order = OrderTrack.new
  expect(@order.order_success.text).to eq "We have received your order"
end
end