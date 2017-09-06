import org.openqa.selenium.WebDriver; 
import org.openqa.selenium.WebElement;

public class FunctionalTest { 
	protected static WebDriver driver; 
	@BeforeClass 
	public static void setUp(){ 
		driver = new FirefoxDriver(); 
		driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS); 
	} 
	@After 
	public void cleanUp(){ 
		driver.manage().deleteAllCookies(); 
	} 
	@AfterClass 
	public static void tearDown(){ 
		driver.close(); 
	} 
}
