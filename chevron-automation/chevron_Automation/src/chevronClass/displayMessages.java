package chevronClass;

import org.testng.Assert;

public class displayMessages {

	public void printMessage(String message) {
		System.out.println(message);
	}
	
	public void FailMessage(String message) {
		Assert.fail(message);
	}
	
	public void Assert(Object actual, Object expected) {
		Assert.assertEquals(actual, expected);
	}
	
	public void wait(Integer duration) throws InterruptedException {
		Thread.sleep(duration);
	}
}
