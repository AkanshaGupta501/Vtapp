describe "Admin Logins to Admin Panel" do
  before(:all) do
    @admin_home = AdminHome.new
  end

  before(:each) do
    @admin_home.load
  end

  scenario "Admin enters invalid email id" do 
    @admin_home.fill_login_details(data_for("admin_login/invalid_email"))
    expect(@admin_home.error_message.text).to eq "These credentials do not match our records."
  end

  scenario "Admin enters invalid password" do
     @admin_home.fill_login_details(data_for("admin_login/invalid_password"))
     expect(@admin_home.error_message.text).to eq "These credentials do not match our records."
  end

  scenario "Admin enters valid credentials" do
     @admin_home.fill_login_details(data_for("admin_login/valid_details"))
     expect(@admin_home.admin_name.text).to eq "CaterCat Admin"
  end
end