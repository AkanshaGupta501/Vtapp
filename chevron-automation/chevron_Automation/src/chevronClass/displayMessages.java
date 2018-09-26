package chevronClass;

import org.testng.Assert;

public class displayMessages {

	public void printMessage(Object message) {
		System.out.println(message);
	}
	
	public void FailMessage(String message) {
		Assert.fail(message);
	}
	
	public void Assert(Object actual, Object expected) {
		Assert.assertEquals(actual, expected);
	}
	
	public void introduceWait(Integer duration) throws InterruptedException {
	    Thread.sleep(duration);
	}

}
