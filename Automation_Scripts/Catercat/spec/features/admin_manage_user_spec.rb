describe "Admin Manages Users" do 
  before(:all) do
    @admin_home = AdminHome.new
  end

  before(:each) do
    @admin_home.load
    @admin_home.fill_login_details(data_for("admin_login/valid_details"))
    expect(@admin_home.admin_name.text).to eq "CaterCat Admin"
    @user = AddNewUser.new
    @user.go_to_users.click
  end

  scenario "Admin Adds New User with invalid email id" do
    @user.add_user_link.click
    @user.fill_user_details(data_for('admin_manage_user/invalid_email'))
    expect(@user.flash_error.text).to eq "Error! Form could not be submitted"
  end

  scenario "Admin adds new user with existing email id" do
    @user.add_user_link.click
    @user.fill_user_details(data_for('admin_manage_user/existing_email'))
    expect(@user.flash_error.text).to eq "Error! Form could not be submitted"
  end

  scenario "Admin Adds New User with correct details" do
    @user.add_user_link.click
    @user.fill_user_details(data_for('admin_manage_user/correct_details'))
    expect(@user.flash_success.text).to eq "Success! User created"
  end

  scenario "Admin edits specific user details" do
    @edit_user = EditUser.new
    @user_details = data_for('admin_manage_user/edit_user') 
    puts @user_details
    @edit_user.rows.each do |value| 
      if value.find("td:nth-child(2)").text == @user_details['email_id']
        value.find("td:nth-child(6) > div > a.btn.btn-default").click
        @edit_user.update_user_details(@user_details)
        expect(@edit_user.flash_success.text).to eql "Success!"
        break
      else
        next
      end
    end
  end
end

