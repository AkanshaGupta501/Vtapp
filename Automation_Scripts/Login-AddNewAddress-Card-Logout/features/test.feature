Feature: User Logins & Change Address & Then Logout
Scenario: Login to Catercat User Panel

  	Given I am on Catercat Main Page
  	When I enter "email" for login with "akansha+963@vinsol.com"
  	Then I enter "password" as password for login "123456"
  	Then I click on "LOG IN" button for login to catercat
  	Then I should see User Name
    Then I Go to "My Profile" Section and "+ Add new Address"
    Then I should enter new address "address" as "NUC Block, Near Gopal Mandir Pitampura-NSP, New Delhi-110034" and "postcode" as "1234" and select "city" as "Crossroads"
 	Then I go to "+ Add new Card" link
 	Then I should enter "nameOnCard" as "Aakanksha Gupta" my "cardNumber" as "4242424242424242" select "cardExpiryMonth" as "Oct" and select "cardExpiryYear" as "19" and save the details
 	Then I should display success message 