describe "User Changes Password"  do
  before do
  	@home = Home.new
    @home.load
    @home.make_user_login
    sleep(6)
    @user_panel = UserPanel.new
    expect(@user_panel).to have_user_name
    @user_panel.go_to_profile
    @user_profile = UserProfile.new
    @user_profile.password_link.click
  end

  scenario "User enters different passwords" do
    @user_profile.change_password.enter_new_password(data_for("user_password/mismatching_password"))
    expect(@user_profile.flash_error.text).to eq "Error! Password could not be updated"
  end

  scenario "User old password does not match" do
    @user_profile.change_password.enter_new_password(data_for("user_password/invalid_old_password"))
    expect(@user_profile.flash_error.text).to eq "Error! Password could not be updated"
  end


  scenario "User enters valid password" do
    @user_profile.change_password.enter_new_password(data_for("user_password/valid_password"))
    expect(@user_profile.flash_success.text).to eq "Success! Password updated successfully"
  end
end