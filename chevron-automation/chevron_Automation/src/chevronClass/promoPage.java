package chevronClass;

import static io.appium.java_client.touch.offset.PointOption.point;

import java.util.List;

import org.openqa.selenium.By;
import org.openqa.selenium.Dimension;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import io.appium.java_client.MobileElement;
import io.appium.java_client.TouchAction;
import io.appium.java_client.android.AndroidDriver;



public class promoPage {
    displayMessages display = new displayMessages();
    homePage home = new homePage();
    
  public void verifyFeaturedPromosAreVisible(AndroidDriver driver) {
      try {
          display.introduceWait(5000);
          String header = driver.findElementById("com.chevron:id/distance_bucket_row_text").getText();
          display.Assert(header, "Featured Promotions");
          display.printMessage("Featured Promotions Seen");
      }
      catch(Exception noSuchElementFound) {
          display.FailMessage("Featured Promotions could not be found");
      }
  }
  
  public void verifyFooter(AndroidDriver driver) {
      try {
          display.introduceWait(5000); 
          display.Assert(driver.findElementById("com.chevron:id/promotions_legal_banner").isDisplayed(), true);
          display.printMessage("Footer Seen");
      }
      catch(Exception noSuchElementFound) {
          display.FailMessage("No footer found");
      } 
  }
  
  public void verifyExtraMilePromosAreVisible(AndroidDriver driver) throws InterruptedException {
     display.introduceWait(8000);
      scrollToBottom(driver, 0.9, 0.6);
      try {
          String header = driver.findElementById("com.chevron:id/distance_bucket_row_text").getText();
         display.Assert(header, "ExtraMile Promotions");
          display.printMessage(driver.findElementById("com.chevron:id/distance_bucket_row_text").getText());
      }
      catch(Exception noSuchElementFound) {
          display.FailMessage("No ExtraMile promotions found");
      }
  }
  
  public void verifyBackButton(AndroidDriver driver) throws InterruptedException {
      display.introduceWait(5000);
      WebDriverWait wait = new WebDriverWait(driver, 5000);
      try {
          wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("com.chevron:id/header_menu_text")));
          String headerText = driver.findElementById("com.chevron:id/header_menu_text").getText();
         display.Assert(headerText, "Back");
          driver.findElementById("com.chevron:id/header_menu_text").click();
         display.Assert(driver.findElementById("com.chevron:id/home_heading_container").isDisplayed(), true);
          display.printMessage("Back Button is working fine");
      }
      catch(Exception noSuchElementFound) {
          display.FailMessage("No Back Button found");
      }
  }
  
  public void verifyPromoPopUp(AndroidDriver driver) throws InterruptedException {
      display.introduceWait(5000);
      scrollToBottom(driver, 0.9, 0.1);
      try {
          List<MobileElement> elements =  (List<MobileElement>) driver.findElementsById("com.chevron:id/promotions_regional_row_parent");
          MobileElement desiredElement = elements.get(2);
          desiredElement.findElementById("com.chevron:id/promotions_regional_row_header_container").click();
          scrollToBottom(driver, 0.8, 0.5);
          
          try {
              MobileElement promo = (MobileElement) driver.findElementById("com.chevron:id/promotions_regional_row_extended_details_button");
              display.printMessage(promo.getText());
             display.Assert(promo.getText(), "Touch for details");
              promo.click();
              try {
                 display.Assert(driver.findElementById("com.chevron:id/promotion_detail_dialog_header").isDisplayed(), true);
                  display.printMessage("Pop-Up Displayed");
                  try {
                      driver.findElementById("com.chevron:id/promotion_detail_dialog_close_button").click();
                      display.printMessage("Pop Up Closed");
                  }
                  catch(Exception noCloseButton) {
                      display.FailMessage("Modal Close Button Not found");
                  }
              }
              catch(Exception noModalSeen) {
                  display.FailMessage("No modal promo details found");
              }
          }
          catch(Exception noPromotions) {
              display.FailMessage("No promotions found in Extra Mile Listing");
          }
      }
      catch(Exception noPromosFound){
          display.FailMessage("No ExtraMile Promos found");
      }
  }
  
  
  public void scrollToBottom(AndroidDriver driver, Double valueStartY, Double valueEndY) throws InterruptedException {
      Dimension size= driver.manage().window().getSize();
        int starty=(int)(size.height * valueStartY);
        int endy=(int)(size.height * valueEndY);
        int startx=size.width/2;
        //display.printMessage(starty + "\t" + endy);
        TouchAction action = new TouchAction(driver);
        action.press(point(startx, starty)).waitAction().moveTo(point(startx, endy)).release().perform();
    }
}
