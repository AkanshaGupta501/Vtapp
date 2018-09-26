package testCases;

import java.net.MalformedURLException;

import org.testng.annotations.AfterMethod;
import org.testng.annotations.BeforeMethod;
import org.testng.annotations.Test;
import chevronClass.fakegpsApp;
import chevronClass.homePage;
import chevronClass.stationsNearMe;
import io.appium.java_client.android.AndroidDriver;

public class stationNearByTestCases {

    AndroidDriver driver;
    homePage homeObj = new homePage();
    fakegpsApp fakegps = new fakegpsApp();
    stationsNearMe nearMe = new stationsNearMe();
    
    @BeforeMethod
    public void setup() throws MalformedURLException {
        driver = homeObj.setup();
    }
    
    @Test(priority = 1)
    //Set the Mock location to San Francisco, for successful testing of the cases
    public void setupMockLocation() throws MalformedURLException, InterruptedException {
        homeObj.closeApp();
        fakegps.setup();
        fakegps.playSelectedLocation();
        setup();
    }
    
    @Test(priority = 2)
    //Verify Stations Details to match with Details on ListView
    public void verifyBackButtonfeature() {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyBackButton(driver);
    }
    
    @Test(priority = 3)
    //Verify Stations Details to match with Details on ListView
    public void matchDetails() {
        homeObj.navigateToStationsNearMe();
        nearMe.matchStationDetails(driver);
    }
    
    @Test(priority = 4)
    //Verify all station Details in Amenities
    public void verifyAmenitiesFilters() {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyAmenitiesFilter(driver);
    }
    
    @Test(priority = 5)
    //Verify amenities close Functionality
    public void verifyAmenitiesClosefeature() {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyAmenitiesClose(driver);
    }
    
    @Test(priority = 6)
    //verify the phone dialer functionality from Station Details
    public void verifyPhoneDialer() {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyPhoneDialer(driver);
    }
    
    @Test(priority = 7)
    //Verify the Feedback Form feature from Station Details
    public void verifyFeedbackForm() throws InterruptedException {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyFeedbackLink(driver);
    }
    
    @Test(priority = 8)
    //verify directions App to show the suggestions, verify Address, close from DetailView
    public void verifyDirectionsStationDetails() throws InterruptedException {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyDirectionsDetailView(driver);
    }
    
    @Test(priority = 9)
    //Verify Detail Modal Close Button
    public void verifyDetailClosefeature() throws InterruptedException {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyDetailModalCloseFunctionality(driver);
    }
    
    @Test(priority = 10)
    //Verify directions App to show the suggestions, address and close from ListView
    public void verifyDirectionsfromList() throws InterruptedException {
        homeObj.navigateToStationsNearMe();
        nearMe.verifyDirectionListView(driver);
    }
    
    @AfterMethod
    public void quitApp() {
        homeObj.closeApp();
    }
}
