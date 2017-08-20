Feature: Catercat Admin Page Login
  Scenario: Login to catercat admin panel with email and password
    Given I am on CaterCat Page
    When I enter "email" for login with "akansha@vinsol.com"
    Then I enter "password" as password for login "123456"
    Then I click "LOG IN" button
    Then I should see User Name
    Then I click logout