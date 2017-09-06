describe "User Adds New Address"  do
  before(:all) do
  	@home = Home.new
    @home.load
    @home.login_modal_window.click
    @home.loginmodal.fill_login_details(data_for("login/valid_email_password"))
    @user_panel = UserPanel.new
    expect(@user_panel.user_name.text).to eq "Akanshq Gupta"
    @user_panel.user_name.click
    @user_panel.click_link('My Profile')
  end

  scenario "User doesnot enter postcode" do
  	@user_profile = UserProfile.new
  	page.click_on("+ Add new Address")
  	within("div#addAddressModal", visible: true) do
  		@user_profile.fill_new_address(data_for("user_address/valid_address"))
  	expect(@user_profile.has_content?("Success! Address Created"))
  end
end
end