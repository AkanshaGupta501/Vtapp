import org.openqa.selenium.WebDriver; 
import org.openqa.selenium.WebElement;

public class PageObject { 
	protected WebDriver driver; 
	public PageObject(WebDriver driver){ 
		this.driver = driver; 
		PageFactory.initElements(driver, this); 
	} 
}
