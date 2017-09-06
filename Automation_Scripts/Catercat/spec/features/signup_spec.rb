describe "User Signup" do
	before do
		@home = Home.new
		@home.load
		@home.login_modal_window.click
		@home.signup_modal_window.click
	end

	scenario "Invalid Password Length" do
		@home.signupmodal.fill_signup_details(data_for('signup/invalid_passwords'))
		# expect(@home.signupmodal.error_message.text).to eq "Password should be minimum of 8 characters"
		expect(page.has_content?('Password should be minimum of 8 characters')).to equal true
	end

	scenario "Existing Email Id" do
		@home.signupmodal.fill_signup_details(data_for('signup/existing_email'))
		expect(@home.signupmodal.error_message.text).to eq "Account already exists"
	end

	scenario "Valid Credentials" do
		@home.signupmodal.fill_signup_details(data_for('signup/valid_signup_data'))
		@user_panel = UserPanel.new
		@user_info =  data_for('signup/valid_signup_data')
		@username =  @user_info['firstname'] + " "+ @user_info['lastname']
		expect(@user_panel.user_name.text).to eq @username
	end
end
