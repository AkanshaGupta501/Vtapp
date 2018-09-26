package testCases;

import java.net.MalformedURLException;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import chevronClass.homePage;
import io.appium.java_client.android.AndroidDriver;

public class homeTestCases {
homePage homeObj = new homePage();	
AndroidDriver driver;
	
	@BeforeMethod
	public void setup() throws MalformedURLException {
		driver = homeObj.setup();
	}
	
	/*This test will only work on the first launch of the application after installation,kindly test accordingly*/
	@Test(priority = 1)
	public void seeUpdateDialog() {
		homeObj.locationPermissionActions();
		homeObj.seeUpdateDialog();
	}
	
	@Test(priority = 2)
	public void verifyCountOnRedBanner() throws InterruptedException {
		homeObj.verifycountOnRedBanner(driver);
	}
	
	@AfterMethod
	public void closeApplication() {
		homeObj.closeApp();
	}
}
