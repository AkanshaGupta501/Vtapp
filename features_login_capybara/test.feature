Feature: Catercat Admin Page Login
  Scenario: Login to catercat admin panel with email and password
    Given I am on CaterCat Admin Page
    When I enter "email" for login with "admin@catercat.com"
    Then I enter "password" as password for login "k4fecn6"
    Then I click "Login" button
    Then I should see "Catercat Admin"
    Then I should logout