describe "User Adds New Address"  do
  before do
  	@home = Home.new
    @home.load
    @home.make_user_login
    @user_panel = UserPanel.new
    sleep(6)
    # expect(@user_panel).to have_user_name
    @user_panel.go_to_profile
    @profile = UserProfile.new
    @profile.address_link.click
    sleep(1)
  end

  scenario "User does not enter province" do
    @profile.add_address.click
    @profile.wait_until_add_address_modal_visible
    @profile.add_address_modal.fill_new_address(data_for("user_address/missing_province"))
    expect(@profile.add_address_modal.error_message.text).to eq "Province field is required"
  end

  scenario "User does not enter suburb" do
    @profile.add_address.click
    @profile.wait_until_add_address_modal_visible
    @profile.add_address_modal.fill_new_address(data_for("user_address/missing_suburb"))
    expect(@profile.add_address_modal.error_message.text).to eq "Suburb field is required"
  end

   scenario "User does not enter address" do
    @profile.add_address.click
    @profile.wait_until_add_address_modal_visible
    @profile.add_address_modal.fill_new_address(data_for("user_address/missing_address"))
    expect(@profile.add_address_modal.error_message.text).to eq "Address field is required"
  end


  scenario "User enters valid address" do
    @profile.add_address.click
    @profile.wait_until_add_address_modal_visible
    @profile.add_address_modal.fill_new_address(data_for("user_address/valid_address"))
    expect(@profile.flash_success.text).to eq "Success! Address created"
  end
  
  scenario "User updates address" do
    @profile.edit_address_link.click
    @profile.wait_until_edit_address_modal_visible
    @profile.edit_address_modal.update_address(data_for('user_address/update_address'))
    expect(@profile.flash_success.text).to eq "Success! Address updated"
  end

  scenario "User sets an address as default address" do
    @profile.set_default_address.click
    @profile.wait_until_default_address_modal_visible
    @profile.default_address_modal.set_default.click
    expect(@profile.flash_success.text).to eq "Success! Address has been set as Default"
  end

  scenario "User deletes an address" do
    @profile.edit_address_link.click
    @profile.wait_until_edit_address_modal_visible
    @profile.edit_address_modal.delete_address
    expect(@profile.flash_success.text).to eq "Success! Address deleted"
  end
end