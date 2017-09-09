describe "Guest Checkouts the order" do
before(:all) do
	@user = Home.new
	@user.load
end

scenario "Fill in details for checkout" do 
	sleep(5)
	@user = GuestCheckout.new
  @user.fill_checkout_details(data_for('guest_checkout/details'))
end
end