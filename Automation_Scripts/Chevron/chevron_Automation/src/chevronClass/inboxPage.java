package chevronClass;

import java.util.Hashtable;
import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.testng.Assert;

import io.appium.java_client.MobileElement;
import io.appium.java_client.android.AndroidDriver;

public class inboxPage {
  displayMessages display = new displayMessages();
  homePage homeObj = new homePage();
  
  public void verifyBackNavigation(AndroidDriver driver) {
	  try {
		  MobileElement backButton = (MobileElement) driver.findElementById("com.chevron:id/header_menu_text");
		  display.Assert(backButton.getText(), "Back");
		  display.printMessage("Back button found");
		  backButton.click();
		  homeObj.introduceWait(3000);
		  display.Assert(driver.findElementById("com.chevron:id/home_station_finder_head").isDisplayed(), true);
		  display.printMessage("Back Navigation working fine");
	  }
	  catch(Exception noButtonFound) {
		  display.FailMessage("No Back Navigation Button found");
	  }
  }
  
  public void verifyEmptyinbox(AndroidDriver driver) {
	  try {
		  display.Assert(driver.findElementById("com.chevron:id/uas_inbox_no_message_iv").isDisplayed(), true);
		  display.printMessage("Verified - Inbox is empty");
	  }
	  catch(Exception noImageFound) {
		  display.FailMessage("Messages are present in Inbox. Inbox is not empty!!");
	  }  
  }
  
  public boolean checkifInboxEmpty(AndroidDriver driver) {
	  try {
		  display.Assert(driver.findElementById("com.chevron:id/uas_inbox_no_message_iv").isDisplayed(), true);
		  return true;
	  }
	  catch(Exception noMessageFound) {
		  return false;
	  }
  }
  
  public void verifyDeleteMessageFunctionality(AndroidDriver driver) {
	  try {
		  if(checkifInboxEmpty(driver) == false) {
			  List<MobileElement> messagesRow = driver.findElementsByClassName("android.widget.RelativeLayout");
			  MobileElement firstMessage = messagesRow.get(0);
			  String mark1= getMessageMark(firstMessage, driver);
			  homeObj.introduceWait(3000);
			  firstMessage.findElementById("com.chevron:id/uas_inbox_row_logo_image").click();
			  driver.findElementById("com.chevron:id/header_delete_button").click();
			  display.printMessage("First Message deleted successfully");
			  if(checkifInboxEmpty(driver) == false) {
				  List<MobileElement> refreshedmessagesRow = driver.findElementsByClassName("android.widget.RelativeLayout");
				  MobileElement secondMessage = refreshedmessagesRow.get(0);
				  String mark2 = getMessageMark(secondMessage, driver);
				  if(mark1.equals(mark2)) {
					  display.FailMessage("Issue in delete functionality");
				  }
				  else {
					  display.printMessage("Delete functionality working fine.");
				  }
			  }
			  else {
				  display.printMessage("Delete functionality working fine.");
			  }
		  }
		  else {
			  throw new Exception();
		  }
	  }
	  catch(Exception noMessagesFound){
		  display.printMessage("There are no messages to be deleted!!");
	  }
  }
 
  public String getMessageMark(MobileElement message, AndroidDriver driver) {
	  message.findElementById("com.chevron:id/uas_inbox_row_header").click();
	  String mark = driver.findElementById("com.chevron:id/rich_push_message_navigator_msg_count_text").getText();
	  display.printMessage(mark);
	  driver.findElementById("com.chevron:id/header_menu_text").click();
	  return mark;	  
  }
  
}