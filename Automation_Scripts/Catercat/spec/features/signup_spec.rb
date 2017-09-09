describe "User Signup" do
	before do
		@home = Home.new
		@home.load
		@home.load_signup_form
	end

	scenario "Invalid Password Length" do
		@home.signupmodal.fill_signup_details(data_for('signup/invalid_passwords'))
		expect(page.has_content?('Password should be minimum of 8 characters')).to equal true
	end

	scenario "Existing Email Id" do
		@home.signupmodal.fill_signup_details(data_for('signup/existing_email'))
		expect(@home.signupmodal.error_message.text).to eq "Account already exists"
	end

	scenario "Valid Credentials" do
		@user_details = data_for('signup/valid_signup_data')
		@home.signupmodal.fill_signup_details(@user_details)
		@username = @home.get_user_name(@user_details)
		@user_panel = UserPanel.new	
		expect(@user_panel.user_name.text).to eq @username
	end
end
