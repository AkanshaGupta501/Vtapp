package testCases;

import java.net.MalformedURLException;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import chevronClass.homePage;
import chevronClass.inboxPage;
import io.appium.java_client.android.AndroidDriver;

public class inboxTestCases {

	AndroidDriver driver;
	homePage homeObj = new homePage();
	inboxPage inboxObj = new inboxPage();
	
	@BeforeMethod
	public void setup() throws MalformedURLException {
		driver = homeObj.setup();
	}
	
	@Test(priority = 1)
	//Verify that inbox page is seen
	public void verifyInboxPage() {
		homeObj.navigateToInbox();
	}
	
	@Test(priority = 2)
	//Verify that inbox screen, back button is working
	public void verifyInboxBackButton() {
		homeObj.navigateToInbox();
		inboxObj.verifyBackNavigation(driver);
	}
	
/*Make sure to have atleast one message in inbox to test this case*/
/*Probability that same message is sent twice on same day = 1/12, very low*/
	@Test(priority = 3)
	public void verifyDeleteFunctionality() {
		homeObj.navigateToInbox();
		inboxObj.verifyDeleteMessageFunctionality(driver);
	}
	
/*This test will work only when inbox is empty*/	
	@Test(priority = 4)
	public void checkForEmptyInbox() {
		homeObj.navigateToInbox();
		inboxObj.verifyEmptyinbox(driver);
	}
	
	@AfterMethod
	public void close() {
		homeObj.closeApp();
	}
}
