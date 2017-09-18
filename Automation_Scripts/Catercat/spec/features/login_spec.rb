describe "User Login" do
	before do
    @home = Home.new
	  @home.load
	  @home.login_modal_window.click
	end

	scenario "Invalid email id" do
		@home.loginmodal.fill_login_details(data_for("login/invalid_email"))
		expect(@home.loginmodal.error_message.text).to eq "These credentials do not match our records."
	end

  scenario "Valid Login credentials" do
    @home.loginmodal.fill_login_details(data_for("login/valid_email_password"))
    @user_panel = UserPanel.new
    expect(@user_panel.user_name.text).to eq "Akansha Gupta"
  end
end