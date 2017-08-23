Feature: User Logins & Change Address & Then Logout
  Scenario: Login to catercat user panel with email and password
    Given I am on CaterCat Main Page
    When I enter "email" for login with "akansha@vinsol.com"
    Then I enter "password" as password for login "123456"
    Then I click "LOG IN" button
    Then I should see User Name
    Then I should Go to "My Profile" Section
    Then I should enter new address "address" as "Pitampura-NSP, New Delhi" and "postcode" as "1234"
    Then I should logout from the website