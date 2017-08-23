Feature: User Logins & Change Password & Then Logout
  Scenario: Login to catercat user panel with email and password
    Given I am on CaterCat Main Page
    When I enter "email" for login with "akansha@vinsol.com"
    Then I enter "password" as password for login "123456"
    Then I click "LOG IN" button
    Then I should see User Name
    Then I should Go to "My Profile" Section
    Then I should add old password
    Then I should add new password as "123456"
    Then I should add confirm password as "123456"
    Then I should click on Save button
    Then I should logout from the website