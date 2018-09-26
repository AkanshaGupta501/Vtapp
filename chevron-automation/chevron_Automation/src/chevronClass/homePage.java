package chevronClass;

import java.net.MalformedURLException;
import java.net.URL;
import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;


public class homePage {
	
  AndroidDriver driver;
  displayMessages display = new displayMessages();
  stationsNearMe stationsNear =  new stationsNearMe();
  public AndroidDriver setup() throws MalformedURLException {
	  DesiredCapabilities capabilities = new DesiredCapabilities();
		capabilities.setCapability("deviceName", "4d00755e4e3b51c3"); //Galaxy S4
		capabilities.setCapability(CapabilityType.BROWSER_NAME, "");
		capabilities.setCapability(CapabilityType.VERSION, "6.0.1");
		capabilities.setCapability("platformName", "Android");
		capabilities.setCapability("appPackage", "com.chevron");
		capabilities.setCapability("appActivity", "com.chevron.Home");
		capabilities.setCapability("autoGrantPermissions", true);
		capabilities.setCapability("autoAcceptAlerts", true);
		capabilities.setCapability("fullReset", false);
		capabilities.setCapability("noReset", true);
		capabilities.setCapability("unicodeKeyboard", false);
		capabilities.setCapability("resetKeyboard", false);
		driver = new AndroidDriver (new URL("http://0.0.0.0:4723/wd/hub"), capabilities);
		return driver;
  }
  
  public void closeApp() {
	  driver.quit();
  }
 
  public void locationPermissionActions() {
		//Verify the modal text for further action to be performed
		try {
			//String modalMessage = driver.findElementByAccessibilityId("com.android.packageinstaller:id/permission_message").getText();
			driver.findElementByAccessibilityId("com.android.packageinstaller:id/permission_allow_button").click();
			display.printMessage("Location Permission Accepted");
		}
		catch(Exception noSuchElement) {
			display.printMessage("Permission already Accepted");
		}
	}
  
  public void seeUpdateDialog() {
	  try {
		  MobileElement view = (MobileElement) driver.findElementByClassName("android.widget.LinearLayout");
			try {
				String modalHeader = view.findElementByAccessibilityId("com.chevron:id/whats_new_dialog_header").getText();
				display.Assert(modalHeader, "What's new in the update");
				view.findElementByAccessibilityId("com.chevron:id/whats_new_dialog_close_button").click();
				display.printMessage("What's New Dialgoue Seen");
			}
			catch(Exception noElementFound) {
				display.printMessage("No WhatsNew Dialog Seen");
			}
		}
		catch(AssertionError e) {
			display.FailMessage("Unknown Error Occured on HomePage");
		}		  
  }
  
  public void verifycountOnRedBanner(AndroidDriver driver) throws InterruptedException {
	  try {
		    //driver.setLocation(new Location(37.7749, 122.4194, 16));
			display.introduceWait(2000);
			try {
				String countOfStations = driver.findElementById("com.chevron:id/home_nearby_stations_count").getText();
				navigateToStationsFromRedBanner();
				display.introduceWait(5000);
				try {
					String countFromStationsNearMe = stationsNear.returnCountOfStationsNearby(driver);
					display.Assert(countOfStations, countFromStationsNearMe);
					display.printMessage("Count on both pages match\t" + countFromStationsNearMe);
				}
				catch(Exception noElementFound) {
					 display.FailMessage("Counts do not match");
				}
			}
			catch(Exception noStationsNearBy) {
				display.printMessage("No Stations Near By Location");
				navigateToStationsNearMe();
				display.introduceWait(5000);
				try {
					String countFromStationsNearMe = stationsNear.returnCountOfStationsNearby(driver);
					display.Assert("0", countFromStationsNearMe);
					display.printMessage("Count on both pages match\t" + countFromStationsNearMe);
				}
				catch(Exception noElementFound) {
					 display.FailMessage("Counts do not match - No Stations");
				}
			}
	  }
	  catch(AssertionError e){
		  display.FailMessage("Unknown Error in HomePage RedBanner");
	  }
  }
  
  public void navigateToCards() {
		try {
			driver.findElementById("com.chevron:id/home_chevron_cards_head").click();
			display.introduceWait(3000);
			display.printMessage("Navigated to Chevron Cards Screen");
		}
		catch(Exception noElementExist) {
			display.printMessage("Already on Chevron Cards Screen");
		}
	}
  
  public void navigateToPromos() {
		try {
			driver.findElementById("com.chevron:id/home_promotions_head").click();
			display.introduceWait(3000);
			display.printMessage("Navigated to Chevron Promos Screen");
		}
		catch(Exception noElementExist) {
			display.FailMessage("Already on Chevron Promos Screen");
		}
	}
  
  public void navigateToStationsFromRedBanner() {
      try {
          driver.findElementById("com.chevron:id/home_nearby_stations_text").click();
          display.introduceWait(2000);
          display.Assert(driver.findElementById("com.chevron:id/station_finder_fragment_station_near_header").getText(), "Stations near:");
          display.printMessage("Navigated succesfully to Stations Near Me from Red Banner");        
      }
      catch(Exception noClickableElementFound) {
          display.FailMessage("No clickable link found on Red Banner");
      }
  }
  
  public void navigateToStationsNearMe() {
	  try {
		  driver.findElementById("com.chevron:id/home_station_finder_head").click();
		  display.introduceWait(2000);
		  display.Assert(driver.findElementById("com.chevron:id/station_finder_home_fragment_menu_parent").isDisplayed(), true);
		  driver.findElementById("com.chevron:id/station_finder_home_fragment_near_by_btn").click();
          display.introduceWait(3000);
		  display.printMessage("Navigated to Stations Near Me");
	  }
	  catch(Exception noElementExist) {
		  display.FailMessage("Already on Stations Near Me");
	  }
  }
  
  public void navigateToStationsNearAddress() {
      try {
          driver.findElementById("com.chevron:id/home_station_finder_head").click();
          display.introduceWait(2000);
          display.Assert(driver.findElementById("com.chevron:id/station_finder_home_fragment_menu_parent").isDisplayed(), true);
          driver.findElementById("com.chevron:id/station_finder_home_fragment_near_address_btn").click();
          display.introduceWait(3000);
          display.Assert(driver.findElementById("com.chevron:id/filter_bar_layout").isDisplayed(), true);
          display.printMessage("Navigated to Stations That Have");
      }
      catch(Exception noElementExist) {
          display.FailMessage("Already on Stations That Have");
      }
  }
  
  public void navigateToStationsThatHave() {
      try {
          driver.findElementById("com.chevron:id/home_station_finder_head").click();
          display.introduceWait(2000);
          display.Assert(driver.findElementById("com.chevron:id/station_finder_home_fragment_menu_parent").isDisplayed(), true);
          driver.findElementById("com.chevron:id/station_finder_home_fragment_that_have_btn").click();
          display.introduceWait(3000);
          display.Assert(driver.findElementById("com.chevron:id/station_finder_search_edit_text").isDisplayed(), true);
          display.printMessage("Navigated to Stations Near Address");
      }
      catch(Exception noElementExist) {
          display.FailMessage("Already on Stations Near Address");
      }
  }
  
  public void navigateToFeedback() {
	  try {
		  driver.findElementById("com.chevron:id/home_feedback_head").click();
		  display.introduceWait(3000);
		  display.Assert(driver.findElementById("com.chevron:id/feedback_fragment_header_text").isDisplayed(), true);
		  display.printMessage("Navigated to Feedback Screen");
	  }
	  catch(Exception noElementExist) {
		  display.FailMessage("Already on Feedback Page");
	  }
  }
  
  public void navigateToSettings() {
	  try {
		  driver.findElementById("com.chevron:id/home_settings").click();
		  display.introduceWait(3000);
		  display.Assert(driver.findElementById("com.chevron:id/settings_text").isDisplayed(), true);
		  display.printMessage("User navigated to Settings Screen");
	  }
	  catch(Exception noButtonFound) {
		  display.FailMessage("No Settings Link/Button found");
	  }
  }
  
  public void navigateToInbox() {
	  try {
		  driver.findElementById("com.chevron:id/home_inbox_head").click();
          display.introduceWait(3000);
		  display.Assert(driver.findElementById("com.chevron:id/uas_inbox_list").isDisplayed(), true);
		  display.printMessage("Navigated to Inbox Screen");
	  }
	  catch(Exception noLinkFound) {
		  display.FailMessage("No Inbox Link Found");
	  }
  }
  
  public void navigateToIntermediateScreen() {
	  try {
		  driver.findElementById("com.chevron:id/home_station_finder_head").click();
		  display.introduceWait(3000);
		  MobileElement validationSection = (MobileElement) driver.findElementById("com.chevron:id/station_finder_home_fragment_near_by_btn");
		  display.Assert(validationSection.findElementByClassName("android.widget.TextView").getText(), "Near by");
		  display.printMessage("Intermediate Screen Found");
	  }
	  catch(Exception noSuchPageFound) {
		  display.FailMessage("No intermediate screen found");
	  }
  }
} 
