package testCases;

import java.net.MalformedURLException;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;

import chevronClass.homePage;
import chevronClass.promoPage;
import io.appium.java_client.android.AndroidDriver;

public class promoTestCases {
	homePage homeObj = new homePage();
	promoPage promoObj = new promoPage();
	AndroidDriver driver;
	
	@BeforeMethod
	public void setup() throws MalformedURLException {
		driver = homeObj.setup();
	}
	
	@Test(priority = 1)
	public void verifyFeaturedPromotions() {
		homeObj.navigateToPromos();
		promoObj.verifyFeaturedPromosAreVisible(driver);
	}
	
	@Test(priority = 2)
	public void verifyFooter() {
		homeObj.navigateToPromos();
		promoObj.verifyFooter(driver);
	}
	
	@Test(priority = 3)
	public void verifyExtraMilePromotions() throws InterruptedException {
		homeObj.navigateToPromos();
		promoObj.verifyExtraMilePromosAreVisible(driver);
	}
	
	@Test(priority = 4)
	public void verifyBackButtonWorking() {
		homeObj.navigateToPromos();
		promoObj.verifyBackButton(driver);
	}
	
	@Test(priority = 5)
	public void verifyPromoPopUp() throws InterruptedException {
		homeObj.navigateToPromos();
		promoObj.verifyPromoPopUp(driver);
	}
	
	
	@AfterMethod
	public void closeApplication() {
		homeObj.closeApp();
	}
}