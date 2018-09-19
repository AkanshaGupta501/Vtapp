package chevronClass;

import java.net.MalformedURLException;
import java.sql.Driver;
import java.util.List;
import java.util.Set;

import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.touch.TouchActions;
import org.openqa.selenium.remote.RemoteWebDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;
import static io.appium.java_client.touch.offset.PointOption.point;
import chevronClass.homePage;
import io.appium.java_client.MobileElement;
import io.appium.java_client.TouchAction;
import io.appium.java_client.android.AndroidDriver;
import javafx.scene.web.WebView;

public class cardsPage {

displayMessages display = new displayMessages();

	public void validateCardsScreen(AndroidDriver driver) {
		try {
			String textOnCardsSection = "Earn Fuel Credits every fill-up, every time at Chevron and "
					+ "Texaco with a Chevron Techron Advantage™ Card.";
			List <MobileElement> textViews =  driver.findElementsByClassName("android.widget.TextView");
			String textFromApp = textViews.get(1).getText();
			display.printMessage(textFromApp);
			display.Assert(textFromApp, textOnCardsSection);
			display.printMessage("Verified - Chevron Cards Screen");
		}
		catch(AssertionError e) {
			 display.FailMessage("Chevron Cards Screen Not Found");
		}
				
	}
	
	public void verifySypiCredentials(AndroidDriver driver) {
		try {
			MobileElement userName = (MobileElement) driver.findElementById("com.chevron:id/usernameField");
			MobileElement password = (MobileElement) driver.findElementById("com.chevron:id/passwordField");
			userName.sendKeys("chevdcuat1245");
			password.sendKeys("Test14test");
			driver.findElementById("com.chevron:id/loginButton").click();
			WebDriverWait wait = new WebDriverWait(driver, 5000);
			
			try {
				wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/sypi_account_text_current_balance_label")));
				String elementText = driver.findElementById("com.chevron:id/sypi_account_text_current_balance_label").getText();
			    display.Assert(elementText, "Current Balance");
			    display.printMessage("Login Successful - Valid Credentials Provided");
			}
			catch(Exception timeOutVisibility) {
				 display.FailMessage("Sypi User profile Not Found");
			}	
		}
		catch(Exception noSuchPageFound){
		  try {
			    WebDriverWait wait = new WebDriverWait(driver, 5000);
			    wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/currentBalanceLabelText")));
				String elementText = driver.findElementById("com.chevron:id/currentBalanceLabelText").getText();
			    display.Assert(elementText, "Current Balance");
			    display.printMessage("User Already Logged-in");
		  }
		  catch(Exception unknownError) {
			   display.FailMessage("Sypi Page Not Found");
		  }
		}
	}
	
	public void navigateToCreditCardsLogin(AndroidDriver driver) {
		try {
			driver.findElementById("com.chevron:id/cards_fragment_personal_card_login").click();
			
			if(checkIfUserAlreadyLogged(driver)) {
				verifySypiCredentials(driver);
			}
			else {
				verifyProfilePage(driver);
			}
		}
		catch(Exception noElementFound) {
			display.printMessage("Unable to Navigate to Credit Card Login");
		}
	}
	
	public void verifyProfilePage(AndroidDriver driver) {
		try {
			WebDriverWait wait = new WebDriverWait(driver, 5000);
			wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/currentBalanceLabelText")));
			String textFromProfile = driver.findElementById("com.chevron:id/currentBalanceLabelText").getText();
			display.Assert(textFromProfile, "Current Balance");
			display.printMessage("User Credentials are already saved");
		}
		catch(Exception unknownError) {
			 display.FailMessage("Unknown Error Ocuured in Profile Page");
		}
	}
	
	public boolean checkIfUserAlreadyLogged(AndroidDriver driver) throws InterruptedException {
	    WebDriverWait wait = new WebDriverWait(driver, 5000);
	    wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/sypi_fragment_container_tabs")));
	    try {
	    	driver.findElementById("com.chevron:id/disclaimerText").isDisplayed();
	    	return true;
	    	
	    }catch(Exception disclaimerTextNotFound) {
	    	return false;
	    }	
	}
	
	public void personalCardLink(AndroidDriver driver) {
		try {
			driver.findElement(By.id("com.chevron:id/cards_fragment_personal_card_learn_more")).click();
			MobileElement linkHeader = (MobileElement) driver.findElementById("com.chevron:id/browser_dialog_header_text");
			try {
				WebDriverWait wait = new WebDriverWait(driver, 5000);
				wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("android.widget.ListView")));
				display.Assert(linkHeader.getText(), "Learn more");
				verifyNavigationButtons(driver);
				driver.findElementById("com.chevron:id/browser_dialog_done_button").click();
				display.printMessage("Personal Card WebView Seen");
			}
			catch(Exception timeOut) {
				 display.FailMessage("Navigation to given URL failed");
			}	
		}
		catch(Exception nosuchLinkFound) {
		 display.FailMessage("No PersonalCard Link Found");
	   }
	}
	
	public void businessCardLink(AndroidDriver driver) throws InterruptedException {
		try {
		  WebDriverWait wait = new WebDriverWait(driver, 5000);
		  wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/cards_fragment_personal_card_learn_more")));
		  scrollToBottom(driver);
		  driver.findElementById("com.chevron:id/cards_fragment_business_card_learn_more").click();
		  
		  try {
			 MobileElement linkHeader = (MobileElement) driver.findElementById("com.chevron:id/browser_dialog_header_text");
			 display.Assert(linkHeader.getText(), "Learn more");
			 driver.findElementById("com.chevron:id/browser_dialog_done_button").click();
			 display.printMessage("Business Card WebView Seen");
		  }
		  catch(Exception timeOut){
			   display.FailMessage("Navigation to given URL failed");
		  }
		}
		catch(Exception noElementFound) {
			 display.FailMessage("No Business Card Link Found");
		}
	}
	
	public void scrollToBottom(AndroidDriver driver) throws InterruptedException {
		TouchAction action = new TouchAction(driver);
		action.press(point(200, 1000)).moveTo(point(0, 900)).release().perform();
		display.wait(5000);
	}
	
	public void validateBackButton(AndroidDriver driver) {
		driver.findElementById("com.chevron:id/header_menu_text").click();
		WebDriverWait wait =  new WebDriverWait(driver, 5000);
		try {
			wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/home_heading_container")));
			display.printMessage("Navigated Back Successfully");
		}
		catch(Exception improperFunctioning) {
			 display.FailMessage("Back Button is not working as expected");
		}
	}
	
	public void verifyNavigationButtons(AndroidDriver driver) {
		verifyRefreshButton(driver);
		//verifyPreviousButton(driver);
	}
	
	public void verifyRefreshButton(AndroidDriver driver) {
		try {
			driver.findElementById("com.chevron:id/browser_dialog_refresh_button").click();
			WebDriverWait wait =  new WebDriverWait(driver, 5000);
			wait.until(ExpectedConditions.visibilityOfElementLocated(By.className("android.widget.ListView")));
			driver.findElementByClassName("android.widget.ListView").isDisplayed();
			display.printMessage("Refresh Button Worked Successfully");
		}
		catch(Exception noSuchElementFound) {
			 display.FailMessage("Refresh Button did not responded expectedly");
		}
	}

	//Functionality not working as we cannot access or control the actions of WebView
//	public void verifyPreviousButton(AndroidDriver driver) {
//		try {
//			 Set<String> contextNames = driver.getContextHandles();
//		        display.printMessage(contextNames.size());
//		        for (String contextName : contextNames) {
//		            if (contextName.contains("WEBVIEW")){
//		                driver.context(contextName);
//		            }
//		        }
//		        display.printMessage(driver.getCurrentUrl());
//		        //driver.findElementByLinkText("Fuel Credits").click();
//
//		}
//		catch(Exception noSuchElementFound) {
//			// display.FailMessage("Previous Button didn't work expectedly");
//			display.printMessage(noSuchElementFound);
//		}
//	}
}
