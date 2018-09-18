package chevronClass;

import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;

public class intermediateStationPage {

	homePage homeObj = new homePage();
	displayMessages display = new displayMessages();
	
	public void verifyBackButton(AndroidDriver driver) throws InterruptedException {
		try {
			MobileElement backButton = (MobileElement) driver.findElementById("com.chevron:id/header_menu_text");
			display.Assert(backButton.getText(), "Back");
			display.printMessage("Back Button found");
			backButton.click();
			homeObj.introduceWait(3000);
			display.Assert(driver.findElementById("com.chevron:id/home_station_finder_head").isDisplayed(), true);
			display.printMessage("Back Button working fine");
		}
		catch(Exception noBackButtonFound) {
			display.FailMessage("No Back Button found");
		}
	}
}
