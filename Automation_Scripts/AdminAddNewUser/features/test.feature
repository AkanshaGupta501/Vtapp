Feature: Catercat Admin Page Login
  Scenario: Login to catercat admin panel with email and password
    Given I am on CaterCat Admin Page
    When I enter "email" for login with "admin@catercat.com"
    Then I enter "password" as password for login "k4fecn6"
    Then I click "Login" button
    Then I should see Admin Name
    Then I click add new user link "+ Add New User"
    Then I enter user firstname field "firstname" as "Test"
    Then I enter user lastname field "lastname" as "Automated User"
    Then I enter user "email" id as "test2@automated.user"
    Then I select city as "Cape Town" from "city" dropdown
    Then I enter postcode field "postcode" as "1235"
    Then I click on Add Button
    Then I click logout 