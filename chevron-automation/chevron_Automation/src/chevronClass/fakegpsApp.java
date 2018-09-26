package chevronClass;

import java.net.MalformedURLException;
import java.net.URL;

import org.openqa.selenium.remote.CapabilityType;
import org.openqa.selenium.remote.DesiredCapabilities;
import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;

public class fakegpsApp {

	AndroidDriver driver;
	displayMessages display = new displayMessages();
	public void setup() throws MalformedURLException {
		  DesiredCapabilities capabilities = new DesiredCapabilities();
			capabilities.setCapability("deviceName", "4d00755e4e3b51c3");
			capabilities.setCapability(CapabilityType.BROWSER_NAME, "");
			capabilities.setCapability(CapabilityType.VERSION, "6.0.1");
			capabilities.setCapability("platformName", "Android");
			capabilities.setCapability("appPackage", "com.lexa.fakegps");
			capabilities.setCapability("appActivity", "com.lexa.fakegps.ui.Main");
			capabilities.setCapability("autoGrantPermissions", "true");
			capabilities.setCapability("autoAcceptAlerts", "true");
			capabilities.setCapability("fullReset", false);
			capabilities.setCapability("noReset", true);
			capabilities.setCapability("unicodeKeyboard", false);
			capabilities.setCapability("resetKeyboard", false);
			driver = new AndroidDriver (new URL("http://127.0.0.1:4723/wd/hub"), capabilities);
	  }
	
	public void setLocation() throws InterruptedException {
		try {
		    display.introduceWait(5000);
			driver.findElementById("com.lexa.fakegps:id/action_search").click();
			MobileElement searchBar = (MobileElement) driver.findElementById("android:id/search_src_text");
			searchBar.sendKeys("San Francisco \n");
			display.introduceWait(10000);
			display.printMessage("Location Set Successfully in FakeGPS app - San Francisco");
		}
		catch(Exception noSearchButtonFound) {
			display.FailMessage("No search button was found");
		}
	}
	
	public void playSelectedLocation() throws InterruptedException {
		try {
			setLocation();
			driver.findElementById("com.lexa.fakegps:id/action_start").click();
			display.printMessage("Play Button Clicked");
		}
		catch(Exception noPlayButtonFound) {
			display.FailMessage("No Play Button found");
		}
	}
	
	public void pauseLocation() throws InterruptedException {
		try {
			driver.findElementById("com.lexa.fakegps:id/action_stop").click();
			display.introduceWait(300);
			display.printMessage("Pause Button Clicked");
		}
		catch(Exception noPauseButtonFound) {
			display.FailMessage("No Pause Button Found");
		  }
	}
	
	public boolean checkifAppPlayingLocation() {
		try {
			driver.findElementById("com.lexa.fakegps:id/action_stop").isDisplayed();
			display.printMessage("Fake GPS is playing the mock location");
			return true;
		}
		catch(Exception appInPauseState) {
		    display.printMessage("Fake GPS is not playing any mock location");
			return false;
		}
	}
	
	public void closeApp() {
		driver.quit();
	}
}
