describe "Admin Adds New Caterer" do
  before(:all) do
    @admin_home = AdminHome.new
  end

  before(:each) do
    @admin_home.load
    @admin_home.fill_login_details(data_for("admin_login/valid_details"))
    expect(@admin_home.admin_name.text).to eq "CaterCat Admin"
    @caterer = AddNewCaterer.new
    @caterer.go_to_caterer.click
    @caterer.add_caterer_link.click
  end

  scenario "Admin enters incorrect profile details for caterer" do
    @caterer.create_caterer(data_for('admin_manage_caterer/incorrect_profile_details'))
    expect(@caterer.flash_caterer_created_error.text).to eq "Error! Form could not be submitted"
  end

  scenario "Admin enters existing email id in caterer profile" do
    @caterer.create_caterer(data_for('admin_manage_caterer/existing_email'))
    expect(@caterer.flash_caterer_created_error.text).to eq "Error! Form could not be submitted"
  end

  scenario "Admin enters correct details for caterer" do
    @caterer.create_caterer(data_for('admin_manage_caterer/correct_profile_details'))
    expect(@caterer.flash_caterer_created_success.text).to eq "Success! Caterer created successfully"
    @caterer.update_business_details(data_for('admin_manage_caterer/correct_business_details'))
    expect(@caterer.flash_caterer_updated_success.text).to eq "Success! Caterer profile updated successfully"
  end
end