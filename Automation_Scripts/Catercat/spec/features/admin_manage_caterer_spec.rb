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
  end

  # scenario "Admin enters incorrect profile details for caterer" do
  #   @caterer.add_caterer_link.click
  #   @caterer.create_caterer(data_for('admin_manage_caterer/incorrect_profile_details'))
  #   expect(@caterer.flash_caterer_created_error.text).to eq "Error! Form could not be submitted"
  # end

  # scenario "Admin enters existing email id in caterer profile" do
  #   @caterer.add_caterer_link.click
  #   @caterer.create_caterer(data_for('admin_manage_caterer/existing_email'))
  #   expect(@caterer.flash_caterer_created_error.text).to eq "Error! Form could not be submitted"
  # end

  # scenario "Admin enters correct details for caterer" do
  #   @caterer.add_caterer_link.click
  #   @caterer.create_caterer(data_for('admin_manage_caterer/correct_profile_details'))
  #   expect(@caterer.flash_caterer_created_success.text).to eq "Success! Caterer created successfully"
  #   @caterer.update_business_details(data_for('admin_manage_caterer/correct_business_details'))
  #   expect(@caterer.flash_caterer_updated_success.text).to eq "Success! Caterer profile updated successfully"
  # end

  scenario "Admin edits the existing caterer, approved caterer" do
    @edit_caterer = EditCaterer.new
    @caterer_details = data_for('admin_manage_caterer/edit_caterer')
    puts @caterer_details
    @edit_caterer.go_to_approved.click
    @edit_caterer.rows.each do |value|
      if value.find("td.img-flex > div:nth-child(2) > h5").text == @caterer_details['name']
        value.find("td:nth-child(5) > div > a.btn.btn-default").click
        @edit_caterer.edit_contact_details(@caterer_details)
        @edit_caterer.go_to_caterer_profile.click
        @edit_caterer.edit_business_details(@caterer_details)
        @edit_caterer.go_to_orders.click
        @edit_caterer.edit_order_details(@caterer_details)
        @edit_caterer.go_to_availability.click
        @edit_caterer.edit_availability_days(@caterer_details)
        expect(@edit_caterer.flash_caterer_updated_success.text).to eq "Success!"
        break
      else
        next
      end
    end
  end
end