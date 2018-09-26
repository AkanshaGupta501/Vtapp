package chevronClass;

import java.util.HashMap;
import java.util.List;

import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;

public class stationsNearMe {

    displayMessages display = new displayMessages();
    feedbackPage feedBack = new feedbackPage();
    
    public String returnCountOfStationsNearby(AndroidDriver<?> driver) {
        
        return driver.findElementById("com.chevron:id/station_finder_fragment_station_count").getText();
    }
    
    public Boolean verifyIfAmenitiesFilterBarDisplayed(MobileElement option) {
        try {
            if(option.findElementById("com.chevron:id/station_list_item_filter_container").isDisplayed()) {
                return false;
            }
            else {
                return true;
            }
        }
        catch(Exception filtersNotFound) {
            return true;
        }
    }
    
    public MobileElement returnFirstStation(AndroidDriver driver) {
        MobileElement listView = (MobileElement) driver.findElementById("com.chevron:id/stations_list_view");
        List<MobileElement> listOptions = listView.findElementsByClassName("android.widget.RelativeLayout");
        MobileElement firstOption = listOptions.get(0);
        return firstOption;
    }
    
    public void verifyBackButton(AndroidDriver driver) {
        try {
            driver.findElementById("com.chevron:id/header_menu_text").click();
            display.introduceWait(3000);
            display.Assert(driver.findElementById("com.chevron:id/home_station_finder_head").isDisplayed(), true);
            display.printMessage("Back Button working fine");
        }
        catch(Exception noButtonFound) {
            display.FailMessage("No Back Button Found");
        }
    }
    
    public void matchStationDetails(AndroidDriver driver) {
        try {
            display.introduceWait(5000);
            MobileElement firstOption = returnFirstStation(driver);   
            HashMap<String, String> stationDetails = new HashMap<String, String>();
            stationDetails.put("name", firstOption.findElementById("com.chevron:id/station_list_item_station_name").getText());
            stationDetails.put("address", firstOption.findElementById("com.chevron:id/station_list_item_street_address").getText());
            stationDetails.put("miles", firstOption.findElementById("com.chevron:id/station_list_item_distance").getText() + "les");
            firstOption.findElementById("com.chevron:id/station_list_item_details_tv").click();
           
            if(verifyStationDetails(driver, stationDetails) == true) {
                display.Assert(true, true);
                display.printMessage("Station Details Match for a List & Detail View");
            }
            else {
                display.FailMessage("Station Details do not match - Some Error");
            }           
        }
        catch(Exception noStations) {
            display.FailMessage("No stations NearBy");
        }
    }
    
    public Boolean verifyStationDetails(AndroidDriver driver, HashMap<String, String> stationDetails) {
        try {
            String name = driver.findElementById("com.chevron:id/station_finder_detail_fragment_station_name").getText();
            String address = driver.findElementById("com.chevron:id/station_finder_detail_fragment_address_street").getText();
            String miles = driver.findElementById("com.chevron:id/station_finder_detail_fragment_distance").getText();
            
            if(name.equals(stationDetails.get("name"))) {
                display.printMessage(name);
                if(address.equals(stationDetails.get("address"))) {
                    display.printMessage(address);
                    if(miles.equals(stationDetails.get("miles"))) {
                        display.printMessage(miles);
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                else {
                    return false;
                }
            }
            else {
                return false;
            }          
        }
        catch(Exception noDetailsSectionFound) {
            return false;
        }
    }
    
    public void verifyAmenitiesFilter(AndroidDriver driver) {
        try {
            display.introduceWait(3000);
            MobileElement firstOption = returnFirstStation(driver);
            firstOption.findElementById("com.chevron:id/station_list_item_show_hide_tag_tv").click();
            display.introduceWait(1000);
            MobileElement filtersBar = firstOption.findElementById("com.chevron:id/station_list_item_filter_container");
            display.Assert(filtersBar.isDisplayed(), true);
            display.printMessage("Amenities Filters Visible");
            try {
                MobileElement filters = filtersBar.findElementByClassName("android.widget.LinearLayout");
                List<MobileElement> filterRows = filters.findElementsByClassName("android.widget.LinearLayout");
                MobileElement firstRow = filterRows.get(0);
                MobileElement secondRow = filterRows.get(1);
                Integer filtersCount = firstRow.findElementsByClassName("android.widget.TextView").size();
                filtersCount += secondRow.findElementsByClassName("android.widget.TextView").size();
                display.printMessage(filtersCount);
                if (filtersCount == 6) {
                    display.Assert(true, true);
                    display.printMessage("All Filters displayed in Amenities");
                }
                else {
                    display.FailMessage("Incorrect number of filters displayed, expected filters are 6");
                }
            }
            catch(Exception errorInFilters) {
                display.printMessage("Error in Amenities - Filter");
            }
        }
        catch(Exception noSuchElementFound) {
            display.FailMessage("No Amenities link Found");
        }
    }
    
    public void verifyAmenitiesClose(AndroidDriver driver) {
        try {
            display.introduceWait(1000);
            MobileElement firstOption = returnFirstStation(driver);
            MobileElement amenitiesButton = firstOption.findElementById("com.chevron:id/station_list_item_show_hide_tag_tv");
            amenitiesButton.click();
            display.introduceWait(1000);
            display.Assert(firstOption.findElementById("com.chevron:id/station_list_item_filter_container").isDisplayed(), true);
            display.printMessage("Amenities are visible");
            try {
                amenitiesButton.click();
                display.introduceWait(1000);
                if(verifyIfAmenitiesFilterBarDisplayed(firstOption)) {
                    display.Assert(true, true);
                    display.printMessage("Amenities Close working Fine");
                }
                else {
                    throw new Exception();
                }
            }
            
            catch(Exception amenitiesCloseWorking) {
                display.FailMessage("Amenities close not working as expected");
            }
        }
        catch(Exception noAmenitiesButtonFound) {
            display.FailMessage("Amenities Button not found");
        }
    }
    
    public void verifyPhoneDialer(AndroidDriver driver) {
        try {
            display.introduceWait(3000);
            MobileElement firstOption = returnFirstStation(driver);
            firstOption.findElementById("com.chevron:id/station_list_item_details_tv").click();
            try {
                display.introduceWait(1000);
                MobileElement contactNumber = (MobileElement) driver.findElementById("com.chevron:id/station_finder_detail_fragment_call_buttom");
                display.Assert(contactNumber.isDisplayed(), true);
                display.printMessage("Chevron Station provided Contact Number");
                String mobileNumber = contactNumber.getText();
                mobileNumber = mobileNumber.replaceAll("[^0-9]","");
                display.printMessage(mobileNumber);
                contactNumber.click();
                try {
                    display.introduceWait(2000);
                    display.Assert(driver.findElementById("com.android.contacts:id/digits").isDisplayed(),true);
                    display.printMessage("Phone Dialer Opened");
                    display.Assert(driver.findElementById("com.android.contacts:id/digits").getText(), mobileNumber);
                    display.printMessage("Phone Dialer for Stations working fine");
                }
                catch(Exception phoneNumberError) {
                    display.FailMessage("Phone Numbers incorrect");
                }
                
            }
            catch(Exception noPhoneNumberProvided) {
                display.FailMessage("Chevron Staion does not provide contact Number");
            }
        }
        catch(Exception noDetailsLinkFound) {
            display.FailMessage("No details Link Found");
        }
    }
    
    public void verifyFeedbackLink(AndroidDriver driver) throws InterruptedException {
        display.introduceWait(3000);
        MobileElement firstOption = returnFirstStation(driver);
        firstOption.findElementById("com.chevron:id/station_list_item_details_tv").click();
        try {
            display.introduceWait(3000);
            MobileElement feedbackButton = (MobileElement) driver.findElementById("com.chevron:id/station_finder_detail_fragment_feedback_buttom");
            display.Assert(feedbackButton.getText(), "Feedback");
            display.printMessage("Feedback Link found");
            try {
                feedbackButton.click();
                display.introduceWait(5000);
                feedBack.navigationAroundPages(driver);
                try {
                    display.printMessage("Feedback Form Successfully");
                    driver.findElementById("com.chevron:id/feedback_form_fragment_done_button").click();
                    display.printMessage(driver.findElementById("com.chevron:id/station_finder_detail_fragment_station_name").getText());
                    display.Assert(driver.findElementById("com.chevron:id/station_finder_detail_fragment_station_name").isDisplayed(), true);
                    display.printMessage("Done Button working fine");
                }
                catch(Exception stationDetailsNotFound) {
                    display.FailMessage("Done button did not return back to Station Details");
                }
            }
            catch(Exception errorInFillingForm) {
                display.FailMessage("Issue in filling Feedback Form");
            }
        }
        catch(Exception noFeedbackLinkFound) {
            display.FailMessage("No Feedback Link found");
        }
    }
    
    public void verifyDetailModalCloseFunctionality(AndroidDriver driver) throws InterruptedException {
        display.introduceWait(3000);
        MobileElement firstOption = returnFirstStation(driver);
        firstOption.findElementById("com.chevron:id/station_list_item_details_tv").click();
        try {
            driver.findElementById("com.chevron:id/station_finder_detail_fragment_close_button").click();
            display.introduceWait(2000);
            display.Assert(driver.findElementById("com.chevron:id/station_finder_fragment_list_header_layout").isDisplayed(), true);
            display.printMessage("Close Button on Station Details working fine");
        }
        catch(Exception noCloseButtonFound) {
            display.FailMessage("No close button found on Modal");
        }
    }
    
    public void verifyDirectionsDetailView(AndroidDriver driver) throws InterruptedException {
        display.introduceWait(3000);
        MobileElement firstOption = returnFirstStation(driver);
        firstOption.findElementById("com.chevron:id/station_list_item_details_tv").click();
        
        try {
            display.introduceWait(2000);
            String stationAddressId = "com.chevron:id/station_finder_detail_fragment_address_street";
            String stationAddress = driver.findElementById(stationAddressId).getText();
            MobileElement directions = (MobileElement) driver.findElementById("com.chevron:id/station_finder_detail_fragment_direction_buttom");
            display.Assert(directions.getText(), "Directions");
            display.printMessage("Directions Link Found");
            directions.click();
            directionLinkFunctionalities(driver, stationAddress, stationAddressId);
        }
        catch(Exception noDirectionsLinkFound) {
            display.FailMessage("No directions link found");
        }
    }
    
    public void verifyDirectionListView(AndroidDriver driver) throws InterruptedException {
        display.introduceWait(3000);
        MobileElement firstOption = returnFirstStation(driver);
        try {
           MobileElement directions = (MobileElement) firstOption.findElementById("com.chevron:id/station_list_item_direction");
           String stationAddressId = "com.chevron:id/station_list_item_street_address";
           String stationAddress = firstOption.findElementById(stationAddressId).getText();
           display.Assert(directions.getText(), "Directions");
           display.printMessage("Directions Link Found");
           directions.click();
           directionLinkFunctionalities(driver, stationAddress, stationAddressId);
        }
        catch(Exception noirectionsLinkFound) {
            display.FailMessage("No directions Link Button found");
        }
    }
    
    public void directionLinkFunctionalities(AndroidDriver driver, String stationAddress, String afterCloseElementId) {
        try {
            display.introduceWait(1000);
            display.Assert(driver.findElementById("android:id/content").isDisplayed(), true);
            display.printMessage("Directions Modal Seen");
            try {
                display.Assert(driver.findElementById("com.chevron:id/select_default_direction_app_station_name").getText(), stationAddress);
                display.printMessage(stationAddress);
                display.introduceWait(1000);
                display.printMessage("Station Address Visible Correctly");
                try {
                    int flag = 0;
                    if(driver.findElementById("com.chevron:id/select_default_direction_app_google_maps").isDisplayed()) {
                        flag ++;
                        if(driver.findElementById("com.chevron:id/select_default_direction_app_waze_maps").isDisplayed()) {
                            flag ++;
                        }
                    }                       
                   if(flag >=2) {
                       display.Assert(true, true);
                       display.printMessage("Map Application Suggestions are Shown");
                       try {
                           display.introduceWait(1000);
                           driver.findElementById("com.chevron:id/select_default_direction_app_dialog_close_button").click();
                           display.introduceWait(1000);
                           if(driver.findElementById(afterCloseElementId).isDisplayed()) {
                               display.printMessage("Modal Close Button working fine");
                           }
                       }
                       catch(Exception modalCloseNotWorking) {
                           display.FailMessage("Modal Close Button not working");
                       }
                   }
                   else {
                       throw new Exception();
                   }
                 
                }
                catch(Exception noMapSuggestions) {
                    display.FailMessage("No Map Application Suggestions Found");
                }
            }
            catch(Exception errorInStationAddress) {
                display.FailMessage("Station Address incorrect");
            }
        }
        catch(Exception noModalFound) {
            display.FailMessage("No Directions Modal Found");
        }
    }
}
