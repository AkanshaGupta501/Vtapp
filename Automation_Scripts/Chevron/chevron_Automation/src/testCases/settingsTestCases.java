package testCases;

import java.net.MalformedURLException;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import chevronClass.homePage;
import chevronClass.settingsPage;
import io.appium.java_client.android.AndroidDriver;

public class settingsTestCases {
 
	homePage homeObj = new homePage();
	settingsPage settingsObj = new settingsPage();
	AndroidDriver driver;
	
	@BeforeMethod
	public void setup() throws MalformedURLException {
		driver = homeObj.setup();
	}
	
	@Test(priority = 1)
	//verify the version of app is displayed
	public void verifyAppVersion() {
		homeObj.navigateToSettings();
		settingsObj.verifyAppVersion(driver);
	}
	
	@Test(priority = 2)
	//Verify the Privacy Policy Page is Seen
	public void verifyVisibilityOfPrivacyPolicy() throws InterruptedException {
		homeObj.navigateToSettings();
		settingsObj.verifyPrivacyPolicyPage(driver);
	}
	
	@Test(priority = 3)
	//Verify the Header of Privacy Policy
	public void verifyHeaderOfPolicy() {
		homeObj.navigateToSettings();
		settingsObj.verifyHeaderofPrivacyPolicy(driver);
	}
	
	@Test(priority = 4)
	//verify the functionality of Done Button
	public void verifyDoneButton() {
		homeObj.navigateToSettings();
		settingsObj.verifyDoneButtononPrivacyPolicy(driver);
	}
	
	@Test(priority = 5)
	//Verify the working of back button on settings page
	public void verifyBackButton() {
		homeObj.navigateToSettings();
		settingsObj.verifySettingsBackButtonWorking(driver);
	}
	
	@AfterMethod
	public void quit() {
		homeObj.closeApp();
	}
}
