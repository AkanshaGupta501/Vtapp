Feature:Capybara signup script for User on Catercat
  Scenario:Signup on catercat with name email and password
	Given I am on Catercat User Site
	When I enter first name "firstname" as "Testing"
	Then I enter last name "lastname" as "Automata"
	Then I enter email "email" as "akanshagupta+9@gmail.vb"
	Then I enter mobile "mobile" as "12345678"
	Then I enter password "password" as "123456"
	Then I enter confirm password "password_confirmation" as "123456" 
	Then I click signup button "SIGN UP"
	Then I display message of script completion