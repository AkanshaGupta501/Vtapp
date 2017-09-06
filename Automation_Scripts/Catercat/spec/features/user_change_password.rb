describe "User Changes Password"  do
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

  scenario "User enters valid password" do
    @user_profile = UserProfile.new
    @user_profile.change_password.enter_new_password(data_for("user_password/valid_password"))
    # page.should has_content?("Success!Password updated successfully")
    expect(page.should has_content?("Success!Password updated successfully"))
  end
end