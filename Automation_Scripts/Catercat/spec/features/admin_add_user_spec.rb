describe "Admin Adds New User and Caterer" do 
  before(:all) do
    @admin_home = AdminHome.new
  end

  before(:each) do
    @admin_home.load
    @admin_home.fill_login_details(data_for("admin_login/valid_details"))
    expect(@admin_home.admin_name.text).to eq "CaterCat Admin"
    @new_user = AddNewUser.new
    @new_user.go_to_users.click
    @new_user.add_user_link.click
  end

  scenario "Admin Adds New User with invalid email id" do
    @new_user.fill_user_details(data_for('admin_add_new_user/invalid_email'))
    expect(@new_user.flash_error.text).to eq "Error! Form could not be submitted"
  end

  scenario "Admin adds new user with existing email id" do
    @new_user.fill_user_details(data_for('admin_add_new_user/existing_email'))
    expect(@new_user.flash_error.text).to eq "Error! Form could not be submitted"
  end

  scenario "Admin Adds New User with correct details" do
    @new_user.fill_user_details(data_for('admin_add_new_user/correct_details'))
    expect(@new_user.flash_success.text).to eq "Success! User created"
  end
end

