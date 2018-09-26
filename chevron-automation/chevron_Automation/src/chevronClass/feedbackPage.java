package chevronClass;

import java.net.MalformedURLException;
import java.util.List;

import org.openqa.selenium.Dimension;
import io.appium.java_client.MobileElement;
import io.appium.java_client.TouchAction;
import io.appium.java_client.android.AndroidDriver;
import static io.appium.java_client.touch.offset.PointOption.point;
import io.appium.java_client.android.nativekey.AndroidKey;
import io.appium.java_client.android.nativekey.KeyEvent;

public class feedbackPage {

	fakegpsApp fakeGpsObj = new fakegpsApp();
	displayMessages display = new displayMessages();
	
	public void turnOffLocation() throws MalformedURLException, InterruptedException {
		fakeGpsObj.setup();
		if(fakeGpsObj.checkifAppPlayingLocation() == true) {
			fakeGpsObj.pauseLocation();
		}else {
			//Do Nothing
		}
		fakeGpsObj.closeApp();
	}
	
	public void verifyNoListIfLocationUnavailable(AndroidDriver driver) {
		try {
			String status = driver.findElementById("com.chevron:id/feedback_fragment_status_message_text").getText();
			display.Assert(status, "We couldn't find any stations near this location.");
			display.printMessage(status);
		}
		catch(Exception noSuchMessageFound) {
			display.FailMessage("Informative message missing");
		}
	}
	
	public void verifySearchStations(AndroidDriver driver) {
		try {
			driver.findElementById("com.chevron:id/feedback_fragment_find_location_text").click();
			MobileElement searchBar = (MobileElement) driver.findElementById("com.chevron:id/station_finder_search_edit_text");
			searchBar.sendKeys("San Francisco");
			List<MobileElement> suggestions = driver.findElementsByClassName("android.widget.RelativeLayout");
			display.introduceWait(5000);
			MobileElement location = suggestions.get(0);
			display.Assert(location.findElementById("com.chevron:id/suggestions_list_row_text").getText(), "San Francisco, CA");
			location.findElementById("com.chevron:id/suggestions_list_row_text").click();
			display.introduceWait(5000);
			try {
				Boolean stationsListVisible = driver.findElementsById("com.chevron:id/feedback_station_list_item_feedback_rl").isEmpty();
				display.Assert(stationsListVisible, false);
				display.printMessage("Feedback Stations Visible");
			}
			catch(Exception noStationsNearBy) {
				display.FailMessage("There are no stations near By");
			}
		}
		catch(Exception noSuchElementFound) {
			display.FailMessage("No such link found");
		}
	}
	
	public void fillTheFeedbackForm(AndroidDriver driver) {
		try {
			verifySearchStations(driver);
			redirectUserToFeedbackWebPage(driver);
			navigationAroundPages(driver);
			closeFeedBack(driver);
		}
		catch(Exception noStationsFound) {
			display.FailMessage("No Stations Found for submitting the feedback");
		}
	}
	
	public void redirectUserToFeedbackWebPage(AndroidDriver driver) {
		try {
			List<MobileElement> stations = (List<MobileElement>) driver.findElementsById("com.chevron:id/feedback_station_list_item_feedback_rl");
			MobileElement feedbackStation = stations.get(0);
			String stationNumber = feedbackStation.findElementById("com.chevron:id/feedback_station_list_item_name_textview").getText();
			String stationAddress = feedbackStation.findElementById("com.chevron:id/feedback_station_list_item_address_textview").getText();
			String milesAhead = feedbackStation.findElementById("com.chevron:id/feedback_station_list_item_distance_textview").getText();
			printStationDetails(stationNumber, stationAddress, milesAhead);
			feedbackStation.findElementById("com.chevron:id/feedback_station_list_item_feedback_select_button").click();
			display.Assert(driver.findElementById("com.chevron:id/feedback_form_fragment_header_text").getText(), "Feedback");
			display.printMessage("User redirected to Feedback Page");
			display.introduceWait(10000);	
		}
		catch(Exception noWebViewFound) {
			display.FailMessage("Web View is not found");
		}
	}
	
	public void printStationDetails(String number, String address, String distance) {
		display.printMessage("Station Number:\t" + number);
		display.printMessage("Station Address: \t" + address);
		display.printMessage("Station distance from Current Location:\t" + distance);
	}
	
	/* If id's of buttonis provided by client*/
	 public void navigationAroundPages(AndroidDriver driver) {
		try {
			driver.findElementById("to-step-2").click();
			display.introduceWait(5000);
			try {
				display.printMessage("Naviagted to second question");
				verifyPreviousButton(driver, "back-to-1", "to-step-2");
				driver.findElementById("to-step-3").click();
				display.introduceWait(5000);
				try {
					display.printMessage("Naviagted to third question");
					verifyPreviousButton(driver, "from-3-to-2", "to-step-3");
					MobileElement listOptions = (MobileElement) driver.findElementById("contact-by");
					List<MobileElement> options = listOptions.findElementsByClassName("android.view.View");
					MobileElement option3 = options.get(2);
					option3.findElementByClassName("android.widget.Button").click();
					display.introduceWait(6000);
					scrollToBottom(driver, 0.8, 0.1);
				}
				catch(Exception thirdnavigationNotFound) {
					display.FailMessage("Third Navigation was not successful");
				}
			}
			catch(Exception secondNavigationNotFound) {
				display.FailMessage("Second Navigation Button was not successful");
			}
		}
		catch(Exception noNavigationFound) {
			display.FailMessage("Navigation Buttons were not found");
		}
	}
	
	/*If no id is provided from backend for the navigation buttons*/
	
	/*public void navigationAroundPages(AndroidDriver driver) {
        try {
            List<MobileElement> buttonsOnFirstPage = driver.findElementsByClassName("android.widget.Button");
            MobileElement nextButton = buttonsOnFirstPage.get(3);
            nextButton.click();
            display.introduceWait(5000);
            try {
                display.printMessage("Naviagted to second question");
                List<MobileElement> buttonsOnSecondPage = driver.findElementsByClassName("android.widget.Button");
                MobileElement previousButtonSecondPage = buttonsOnSecondPage.get(4);
                MobileElement nextButtonSecondPage = buttonsOnSecondPage.get(5);
                verifyPreviousButton(driver, previousButtonSecondPage, nextButtonSecondPage);
                nextButtonSecondPage.click();
                display.introduceWait(5000);
                try {
                    display.printMessage("Naviagted to third question");
                    List<MobileElement> buttonsOnThirdPage = driver.findElementsByClassName("android.widget.Button");
                    MobileElement previousThirdPage = buttonsOnThirdPage.get(3);
                    verifyPreviousButton(driver, previousThirdPage, nextButtonSecondPage);
                    List<MobileElement> listViews = driver.findElementsByClassName("android.widget.ListView");
                    MobileElement optionsList = listViews.get(2);
                    List<MobileElement> options = optionsList.findElementsByClassName("android.view.View");
                    MobileElement option3 = options.get(2);
                    option3.findElementByClassName("android.widget.Button").click();
                    display.introduceWait(6000);
                    scrollToBottom(driver, 0.8, 0.1);
                }
                catch(Exception thirdnavigationNotFound) {
                    display.FailMessage("Third Navigation was not successful");
                }
            }
            catch(Exception secondNavigationNotFound) {
                display.FailMessage("Second Navigation Button was not successful");
            }
        }
        catch(Exception noNavigationFound) {
            display.FailMessage("Navigation Buttons were not found");
        }
	}*/
	
	public void closeFeedBack(AndroidDriver driver) {
		try {
		    display.introduceWait(3000);
		    MobileElement feedbackBody = (MobileElement) driver.findElementById("feedback-body");
		    feedbackBody.findElementByClassName("android.widget.Button").click();
			display.introduceWait(3000);
			display.Assert(driver.findElementById("com.chevron:id/home_station_finder_head").isDisplayed(), true);
			display.printMessage("Form Filled Successfully");
		}
		catch(Exception closeButton) {
			display.FailMessage("Close Button Option was not found");
		}
	}
	
	public void verifyDialerFeature(AndroidDriver driver) {
		verifySearchStations(driver);
		redirectUserToFeedbackWebPage(driver);
		navigationAroundPages(driver);
		try {
			//List<MobileElement> webViews = driver.findElementsByClassName("android.webkit.WebView");
			//MobileElement webView = webViews.get(1);
			MobileElement feedBackBody = (MobileElement) driver.findElementById("feedback-body");
			List<MobileElement> views = feedBackBody.findElementsByClassName("android.view.View");
			MobileElement subView = views.get(1);
			List<MobileElement> subViews1 = subView.findElementsByClassName("android.view.View");
			MobileElement viewWithMobileNumber = subViews1.get(1);
			viewWithMobileNumber.click();
			display.introduceWait(4000);
			try {
				String contactNumber = driver.findElementById("com.android.contacts:id/digits").getText();
				display.Assert(contactNumber.equals("8552859595"), true);
				display.printMessage("Phone Dialer Feature working successfully");
				navigateBackToApp(driver);
			}
			catch(Exception noDialerFound) {
				display.FailMessage("No Phone Dialer found");
			}
		}
		catch(Exception noContactLinkFound) {
			display.FailMessage("Unable to find the contact number Link");
		}
	}
	
	public void navigateBackToApp(AndroidDriver driver) throws InterruptedException {
	    
	    /*Depending on the device the number of times, the back button has to be pressed*/
	    
		driver.pressKey(new KeyEvent(AndroidKey.BACK));
		//driver.pressKey(new KeyEvent(AndroidKey.BACK));
		//driver.pressKey(new KeyEvent(AndroidKey.BACK));
		display.introduceWait(2000);
		closeFeedBack(driver);
	}
	
	/* If Id of button navigation is provided by client */
	public void verifyPreviousButton(AndroidDriver driver, String previousButtonId, String nextButtonId) throws InterruptedException {
		driver.findElementById(previousButtonId).click();
		display.introduceWait(4000);
		MobileElement nextButton = (MobileElement) driver.findElementById(nextButtonId);
		display.Assert(nextButton.isDisplayed(), true);
		display.printMessage("Previous Button "+ previousButtonId + " working fine" );
		nextButton.click();
		display.introduceWait(5000);
	}
	
	/*If no Id of buttons is provided by client*/
	public void verifyPreviousButton(AndroidDriver driver, MobileElement previousButton, MobileElement nextButton) throws InterruptedException {
        display.introduceWait(4000);
        display.Assert(nextButton.isDisplayed(), true);
        display.printMessage("Previous Button working fine" );
        nextButton.click();
        display.introduceWait(5000);
    }
	
	public void verifyDoneButton(AndroidDriver driver) {
		verifySearchStations(driver);
		redirectUserToFeedbackWebPage(driver);
		try {
			driver.findElementById("com.chevron:id/feedback_form_fragment_done_button").click();
			display.introduceWait(5000);
			display.Assert(driver.findElementById("com.chevron:id/feedback_fragment_find_location_text").isDisplayed(), true);
			display.printMessage("Done Button working successfully");
		}
		catch(Exception noDoneButtonFound) {
			display.FailMessage("No Done Button Found");
		}
	}
	
	public void scrollToBottom(AndroidDriver driver, Double valueStartY, Double valueEndY) throws InterruptedException {
		  Dimension size= driver.manage().window().getSize();
		    int starty=(int)(size.height * valueStartY);
		    int endy=(int)(size.height * valueEndY);
		    int startx=size.width/2;
		    TouchAction action = new TouchAction(driver);
		    action.press(point(startx, starty)).waitAction().moveTo(point(startx, endy)).release().perform();
		}
}
